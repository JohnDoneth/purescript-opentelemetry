module Repr.SemanticType where

import Prelude

import Data.Argonaut.Core (toString)
import Data.Argonaut.Decode.Class (class DecodeJson)
import Data.Argonaut.Decode.Error (JsonDecodeError(..))
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)

data SemanticType = Span | Resource | Event | Metric

derive instance eqSemanticType :: Eq SemanticType

derive instance genericSemanticType :: Generic SemanticType _

instance decodeSemanticType :: DecodeJson SemanticType where 
    decodeJson json = do
        case toString json of
            Just "span" -> Right Span
            Just "resource" -> Right Resource
            Just "event" -> Right Event
            Just "metric" -> Right Metric
            _ -> Left $ UnexpectedValue json
        
instance showSemanticType :: Show SemanticType where show = genericShow