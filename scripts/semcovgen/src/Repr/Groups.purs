module Repr.Groups where

import Data.Either (Either(..))
import Data.Traversable (sequence)
import Prelude
import Repr.SemanticConvention (SemanticConvention)

import Data.Argonaut.Decode.Class (class DecodeJson, decodeJson)
import Data.Argonaut.Decode.Combinators (getField)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)

data Groups = Groups (Array SemanticConvention)

derive instance eqGroups :: Eq Groups

derive instance genericGroups :: Generic Groups _

instance decodeGroups :: DecodeJson Groups where
  decodeJson json = do
    groupsObject <- decodeJson json
    items <- getField groupsObject "groups"
    semconvs <- sequence $ map decodeJson items
    Right $ Groups semconvs

instance showGroups :: Show Groups where
  show = genericShow

instance semigroupGroups :: Semigroup Groups where
  append (Groups a) (Groups b) = Groups (a <> b)

instance monoidGroups :: Monoid Groups where
  mempty = Groups []