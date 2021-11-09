module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Data.Maybe
import Data.Either
import Data.Argonaut.Decode.Class
import Control.Monad.Except
import Data.YAML.Foreign.Decode
import Data.Argonaut.Core
import Data.Argonaut.Decode.Combinators
import Data.Argonaut.Decode.Generic (genericDecodeJson)
import Data.Argonaut.Decode.Error

main :: Effect Unit
main = do
  log "🍝"



data DbSystem = OTHER_SQL


instance showDbSystem :: Show DbSystem where
  show OTHER_SQL = "other_sql"



data Point = Point Int Int

yamlPoint :: String
yamlPoint = """
X: 1
Y: 1
"""


-- getPoint :: Either JsonDecodeError Point
-- getPoint = case runExcept $ parseYAMLToJson yamlPoint of
--   Left err -> Left err
--   Right json -> genericDecodeJson json

-- instance pointJson :: DecodeJson Point where
--   decodeJson s = do
--     obj <- maybe (Left "Point is not an object.") Right (toObject s)
--     x <- getField obj "X"
--     y <- getField obj "Y"
--     pure $ Point x y


type Groups = Array SemanticConvention

type SemanticConvention = {
  id :: String,
  prefix :: String,
  brief :: String,
  span_kind :: String,
  attributes :: Array Attribute
  --stability :: Maybe Stability
}

type Attribute = {
  id :: String,
  tag :: String,
  brief :: String,
  required :: String,
  type :: AttributeTypeInfo
}

type AttributeTypeInfo = {
  allow_custom_values :: Boolean,
  members :: Array AttributeMember
}

type AttributeMember = {
  id :: Boolean,
  value :: Array String,
  brief :: String
}

data Stability = Deprecated | Experimental | Stable

data SpanKind = Client | Server | Producer | Consumer | Internal

