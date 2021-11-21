module Repr.SemanticConvention where

import Prelude
import Repr.SemanticType

import Control.Alt ((<|>))
import Data.Argonaut.Core (toString)
import Data.Argonaut.Decode.Class (class DecodeJson, decodeJson)
import Data.Argonaut.Decode.Combinators (getField, getFieldOptional)
import Data.Argonaut.Decode.Error (JsonDecodeError(..))
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)
import Repr.Attribute (Attribute)

data SemanticConvention = SemanticConvention {
    id :: String,
    type_ :: SemanticType,
    prefix :: Maybe String,
    brief :: Maybe String,
    note :: Maybe String,
    events :: Array String,
    extends :: Maybe String,
    --stability
    deprecated :: Maybe String,
    --span_kind
    attributes :: Array Attribute
    --constraints
}

derive instance eqSemanticConvention :: Eq SemanticConvention

derive instance genericSemanticConvention :: Generic SemanticConvention _

instance decodeSemanticConvention :: DecodeJson SemanticConvention where
  decodeJson json = do
    x <- decodeJson json
    id <- getField x "id"
    type_ <- getField x "type" <|> Right Span
    prefix <- getFieldOptional x "prefix"
    brief <- getFieldOptional x "brief"
    note <- getFieldOptional x "note"
    events <- getField x "events" <|> Right []
    extends <- getFieldOptional x "extends"
    deprecated <- getFieldOptional x "deprecated"
    attributes <- getField x "attributes" <|> Right []

    pure $ SemanticConvention {
        id: id,
        type_: type_,
        prefix: prefix,
        brief: brief,
        note: note,
        events: events,
        extends: extends,
        deprecated: deprecated,
        attributes: attributes
    }

instance showSemanticConvention :: Show SemanticConvention where
  show = genericShow


