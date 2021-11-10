
module OpenTelemetry.SemanticAttributes where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Either (Either(..))
import Control.Monad.Except (runExcept)
import Data.Argonaut.Core (Json, toString)
import Data.Argonaut.Decode.Error (JsonDecodeError(..))
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Data.YAML.Foreign.Decode (parseYAMLToJson)
import Data.Argonaut.Decode.Class (class DecodeJson, decodeJson)
import Data.Argonaut.Decode.Combinators (getField, getFieldOptional)


yamlToJson :: String -> Either String Json
yamlToJson input = case runExcept $ parseYAMLToJson input of
    Left error -> Left $ show error
    Right success -> Right success

parseGroup :: String -> Either String SemanticConvention
parseGroup input = case yamlToJson input of
    Left err -> Left err
    Right success -> case decodeJson success of
        Left left -> Left $ show left
        Right s2 -> Right s2



data AttributeType = 
     String |
     Int |
     Double |
     Boolean |
     StringArray |
     IntArray |
     DoubleArray |
     BooleanArray
     --Enum #TODO

derive instance genericAttributeType :: Generic AttributeType _

instance decodeAttributeType :: DecodeJson AttributeType where 
    decodeJson json = do
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
        
instance showAttributeType :: Show AttributeType where show = genericShow


type Groups = Array SemanticConvention

data Type_ = Span | Resource | Event | Metric

derive instance genericType_ :: Generic Type_ _

instance decodeType_ :: DecodeJson Type_ where 
    decodeJson json = do
        case toString json of
            Just "span" -> Right Span
            Just "resource" -> Right Resource
            Just "event" -> Right Event
            Just "metric" -> Right Metric
            _ -> Left $ UnexpectedValue json
        

instance showType_ :: Show Type_ where show = genericShow

data SemanticConvention = SemanticConvention {
    id :: String,
    type_ :: Maybe Type_,
    prefix :: Maybe String,
    brief :: Maybe String
}

derive instance genericSemanticConvention :: Generic SemanticConvention _

instance decodeSemanticConvention :: DecodeJson SemanticConvention where
  decodeJson json = do
    x <- decodeJson json
    id <- getField x "id"
    type_ <- getFieldOptional x "type"
    prefix <- getFieldOptional x "prefix"
    brief <- getFieldOptional x "brief"
    pure $ SemanticConvention {
        id: id,
        type_: type_,
        prefix: prefix,
        brief: brief
    }

instance showSemanticConvention :: Show SemanticConvention where
  show = genericShow

-- groups ::= semconv
--        | semconv groups

-- semconv ::= id [type] brief [note] [prefix] [events] [extends] [stability] [deprecated] [span_kind] attributes [constraints]

-- id    ::= string

-- type ::= "span" # Default if not specified
--      |   "resource"
--      |   "event"
--      |   "metric"

-- brief ::= string
-- note  ::= string

-- prefix ::= string

-- extends ::= string

-- stability ::= "deprecated"
--           |   "experimental"
--           |   "stable"

-- deprecated ::= <description>

-- span_kind ::= "client"
--           |   "server"
--           |   "producer"
--           |   "consumer"
--           |   "internal"


-- attributes ::= (id type brief examples | ref [brief] [examples]) [tag] [stability] [deprecated] [required] [sampling_relevant] [note]

-- # ref MUST point to an existing attribute id
-- ref ::= id

-- type ::= "string"
--      |   "int"
--      |   "double"
--      |   "boolean"
--      |   "string[]"
--      |   "int[]"
--      |   "double[]"
--      |   "boolean[]"
--      |   enum

-- enum ::= [allow_custom_values] members

-- allow_custom_values := boolean

-- members ::= member {member}

-- member ::= id value [brief] [note]

-- required ::= "always"
--          |   "conditional" <condition>


-- # EXPERIMENTAL: Using this is NOT ALLOWED in the specification currently.
-- sampling_relevant ::= boolean

-- examples ::= <example_value> {<example_value>}

-- constraints ::= constraint {constraint}

-- constraint ::= any_of
--            |   include

-- any_of ::= id {id}

-- include ::= id