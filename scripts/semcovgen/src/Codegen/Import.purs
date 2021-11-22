module Codegen.Import where

import Prelude
import Data.Foldable
import Data.String.Extra
import Data.Array (concat)

type ImportSegments = Array String

data Import = Import ImportSegments

instance showImport :: Show Import where
  show (Import segments) = "import " <> intercalate "." (map pascalCase segments)