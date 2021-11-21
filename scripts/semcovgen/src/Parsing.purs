module Parsing where

import Prelude

import Control.Monad.Except (runExcept)
import Data.Argonaut.Core (Json)
import Data.Argonaut.Decode (class DecodeJson)
import Data.Argonaut.Decode.Class (decodeJson)
import Data.Either (Either(..))
import Data.YAML.Foreign.Decode (parseYAMLToJson)
import Repr.Groups (Groups)

yamlToJson :: String -> Either String Json
yamlToJson input = case runExcept $ parseYAMLToJson input of
    Left error -> Left $ show error
    Right success -> Right success


parse :: forall a. DecodeJson a => String -> Either String a
parse input = case yamlToJson input of
    Left err -> Left err
    Right success -> case decodeJson success of
        Left left -> Left $ show left
        Right s2 -> Right s2

parseGroups :: String -> Either String Groups
parseGroups = parse


-- type Groups = Array SemanticConvention

-- type SemanticConvention = {
--   id :: String,
--   prefix :: String,
--   brief :: String,
--   span_kind :: String,
--   attributes :: Array Attribute
--   --stability :: Maybe Stability
-- }

-- type Attribute = {
--   id :: String,
--   tag :: String,
--   brief :: String,
--   required :: String,
--   type :: AttributeTypeInfo
-- }

-- type AttributeTypeInfo = {
--   allow_custom_values :: Boolean,
--   members :: Array AttributeMember
-- }

-- type AttributeMember = {
--   id :: Boolean,
--   value :: Array String,
--   brief :: String
-- }

-- data Stability = Deprecated | Experimental | Stable

-- data SpanKind = Client | Server | Producer | Consumer | Internal

