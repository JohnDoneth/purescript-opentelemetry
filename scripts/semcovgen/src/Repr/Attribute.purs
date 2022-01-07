module Repr.Attribute where

import Prelude

import Control.Alt ((<|>))
import Data.Argonaut.Decode (decodeJson, getField)
import Data.Argonaut.Decode.Class (class DecodeJson)
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)
import Data.String (trim)
import Repr.AttributeType (AttributeType, setEnumID)

data Required = Always | Conditional

derive instance genericRequired :: Generic Required _
derive instance eqRequired :: Eq Required
instance showRequired :: Show Required where
  show = genericShow

data Attribute
  = Definition
      { id :: String
      , type_ :: AttributeType
      , brief :: String
      , examples :: Array String
      , tag :: Maybe String
      ,
        --required :: Required,
        samplingRelevant :: Boolean -- defaults to false
      --[tag] [stability] [deprecated] [required] [sampling_relevant] [note]
      }
  | Reference {}

derive instance genericAttribute :: Generic Attribute _
derive instance eqAttribute :: Eq Attribute
instance showAttribute :: Show Attribute where
  show = genericShow

instance decodeAttribute :: DecodeJson Attribute where
  decodeJson json = do
    x <- decodeJson json
    id <- getField x "id"
    type_ <- getField x "type"
    brief <- getField x "brief"
    samplingRelevant <- getField x "sampling_relevant" <|> Right false
    pure $ Definition
      { id: id
      , type_: setEnumID type_ id
      , brief: trim brief
      , examples: []
      , tag: Nothing
      , samplingRelevant: samplingRelevant
      }

