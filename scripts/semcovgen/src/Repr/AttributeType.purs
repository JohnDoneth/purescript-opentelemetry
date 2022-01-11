module Repr.AttributeType (AttributeType(..), EnumMember(..), toPureScriptType, toPureScriptExpr, setEnumID) where

import Prelude

import Codegen.Expression (Expression(..), Typeclass(..), TypeclassBody(..))
import Data.Argonaut.Core (Json, stringify, toArray, toObject, toString)
import Data.Argonaut.Decode (JsonDecodeError(..), decodeJson, getField)
import Data.Argonaut.Decode.Class (class DecodeJson)
import Data.Either (Either(..), note)
import Data.Generic.Rep (class Generic)
import Data.Map (Map, toUnfoldable)
import Data.Map as Map
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)
import Data.String.Extra (pascalCase)
import Data.Traversable (sequence)
import Data.Tuple (Tuple(..))
import Effect.Console (log)
import Effect.Unsafe (unsafePerformEffect)


data EnumMember = EnumMember {
    value :: String,
    brief :: String
}

derive instance genericEnumMember :: Generic EnumMember _
derive instance eqEnumMember :: Eq EnumMember
instance showEnumMember :: Show EnumMember where show = genericShow
instance decodeEnumMember :: DecodeJson EnumMember where 
    decodeJson json = do
        obj <- decodeJson json
        value <- getField obj "value"
        brief <- getField obj "brief"
        Right $ EnumMember {
            value: value,
            brief: brief
        }

data AttributeType = 
     String |
     Int |
     Double |
     Boolean |
     StringArray |
     IntArray |
     DoubleArray |
     BooleanArray |
     Enum {
        id :: String,
        allowCustomValues :: Boolean,
        members :: Map String EnumMember 
     }

toPureScriptType :: AttributeType -> String
toPureScriptType String = "String"
toPureScriptType Int = "Int"
toPureScriptType Double = "Number"
toPureScriptType Boolean = "Boolean"
toPureScriptType StringArray = "(Array String)"
toPureScriptType IntArray = "(Array Int)"
toPureScriptType DoubleArray = "(Array Number)"
toPureScriptType BooleanArray = "(Array Boolean)"
toPureScriptType (Enum {id: id}) = pascalCase id

toPureScriptExpr :: AttributeType -> Maybe Expression
-- toPureScriptExpr (Enum {
--         id: _id, 
--         allowCustomValues: _allowCustomValues, 
--         members: _members
--     }) = Just (TypeclassExpr (Typeclass {typeclass: "test", type_: toPureScriptType , body: []}))
toPureScriptExpr (Enum enum) = 
    Just (TypeclassExpr (Typeclass {
            typeclass: "Show", 
            type_: toPureScriptType (Enum enum), 
            body: typeclassBodiesFromMembers enum.members 
                    <> customMemberTypeclassBody enum.allowCustomValues enum.id
        }))
toPureScriptExpr _ = Nothing



typeclassBodiesFromMembers :: Map String EnumMember -> Array TypeclassBody
typeclassBodiesFromMembers input = 
    let 
        unfolded :: Array (Tuple String EnumMember)
        unfolded = toUnfoldable input in
        map (\(Tuple key value) -> typeclassBodyFromMember key value) unfolded


typeclassBodyFromMember :: String -> EnumMember -> TypeclassBody
typeclassBodyFromMember key (EnumMember member) =
  (TypeclassBody {
      function: "show", 
      args: pascalCase key, 
      expression: "\"" <> member.value <> "\""
      })


customMemberTypeclassBody :: Boolean -> String -> Array TypeclassBody
customMemberTypeclassBody false _ = []
customMemberTypeclassBody true name = 
    [TypeclassBody {
      function: "show", 
      args: "(" <> (pascalCase ("custom_" <> name)) <> " value)", 
      expression: "value"
      }]

derive instance genericAttributeType :: Generic AttributeType _
derive instance eqAttributeType :: Eq AttributeType
instance showAttributeType :: Show AttributeType where show = genericShow
instance decodeAttributeType :: DecodeJson AttributeType where 
    decodeJson json = do
        let x = unsafePerformEffect $ log $ stringify json
        case toObject json of
            Just obj -> do
                allowCustomValues <- getField obj "allow_custom_values"
                members <- getField obj "members"
                decodedMembers <- jsonMembers members
                let x = unsafePerformEffect $ log $ "debug: " <> show decodedMembers
                Right $ Enum {
                    id: "",
                    allowCustomValues: allowCustomValues,
                    members: decodedMembers
                }

            Nothing ->
                case toString json of
                    Just "string" -> Right String
                    Just "int" -> Right Int
                    Just "double" -> Right Double
                    Just "boolean" -> Right Boolean
                    Just "string[]" -> Right StringArray
                    Just "int[]" -> Right IntArray
                    Just "double[]" -> Right DoubleArray
                    Just "boolean[]" -> Right BooleanArray
                    _ -> Left $ UnexpectedValue json
        

jsonMembers :: Json -> Either JsonDecodeError (Map String EnumMember)
jsonMembers json = do
  array <- note (TypeMismatch "Expected array") (toArray json)
  items <- sequence $ map jsonMember array
  Right $ Map.fromFoldable items

jsonMember :: Json -> Either JsonDecodeError (Tuple String EnumMember)
jsonMember json = do
    obj <- decodeJson json
    id <- getField obj "id"
    enumMember <- decodeJson json
    Right $ Tuple id enumMember


setEnumID :: AttributeType -> String -> AttributeType
setEnumID (Enum enum) id = Enum $ enum { id = id }
setEnumID x _ = x

