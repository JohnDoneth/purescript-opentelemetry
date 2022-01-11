module Codegen.Import where

import Prelude

import Data.Foldable (intercalate)
import Data.String.Extra (pascalCase)

import Codegen.Function (tellLine)
import Control.Monad.Writer.Class (class MonadTell)

type ImportSegments = Array String

data Import = Import ImportSegments

encodeImport :: forall m. MonadTell String m => Import -> m Unit
encodeImport (Import segments) = 
  tellLine $ "import " <> intercalate "." (map pascalCase segments)

instance showImport :: Show Import where
  show (Import segments) = "import " <> intercalate "." (map pascalCase segments)

