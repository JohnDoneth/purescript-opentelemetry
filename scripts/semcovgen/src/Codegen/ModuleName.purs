module Codegen.ModuleName where

import Prelude
import Data.Foldable
import Data.String.Extra
import Data.Array (concat)

type ModuleSegments = Array String

newtype ModuleName = ModuleName ModuleSegments

instance showModuleName :: Show ModuleName where
  show (ModuleName segments) = intercalate "." (map pascalCase segments)