module Repr.Groups where

import Data.Argonaut.Core
import Data.Either
import Data.Traversable
import Prelude
import Repr.SemanticConvention

import Data.Argonaut.Decode.Class (class DecodeJson, decodeJson)
import Data.Argonaut.Decode.Combinators (getField, getFieldOptional)
import Data.Argonaut.Decode.Error (JsonDecodeError(..))
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)
import Effect.Class.Console (log, logShow)
import Effect.Unsafe (unsafePerformEffect)

newtype Groups = Groups (Array SemanticConvention)

derive instance eqSemanticConvention :: Eq Groups

derive instance genericSemanticConvention :: Generic Groups _

instance decodeSemanticConvention :: DecodeJson Groups where
  decodeJson json = do
    groupsObject <- decodeJson json
    items <- getField groupsObject "groups"
    semconvs <- sequence $ map decodeJson items 
    Right $ Groups semconvs

instance showSemanticConvention :: Show Groups where
  show = genericShow
