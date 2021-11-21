module Repr.AttributeType (AttributeType(..), EnumMember(..)) where

import Data.Either
import Data.Tuple
import Prelude

import Data.Argonaut.Core (Json, stringify, toArray, toObject, toString)
import Data.Argonaut.Decode (JsonDecodeError(..), decodeJson, getField)
import Data.Argonaut.Decode.Class (class DecodeJson)
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Map (Map)
import Data.Map as Map
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)
import Data.Traversable (sequence)
import Effect.Class.Console (log, logShow)
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
        allowCustomValues :: Boolean,
        members :: Map String EnumMember 
     }

derive instance genericAttributeType :: Generic AttributeType _
derive instance eqAttributeType :: Eq AttributeType
instance showAttributeType :: Show AttributeType where show = genericShow
instance decodeAttributeType :: DecodeJson AttributeType where 
    decodeJson json = do
        --let x = unsafePerformEffect $ log $ stringify json
        case toObject json of
            Just obj -> do
                allowCustomValues <- getField obj "allow_custom_values"
                members <- getField obj "members"
                decodedMembers <- jsonMembers members
                Right $ Enum {
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
