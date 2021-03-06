module Codegen.Module where

import Prelude
import Data.Foldable
import Data.String.Extra
import Data.Array (concat)

import Codegen.Import
import Codegen.ModuleName
import Codegen.Expression

data Module = Module {
    name :: ModuleName,
    imports :: Array Import,
    expressions :: Array Expression
}

instance showModule :: Show Module where
  show (Module {name: name, imports: imports, expressions: expressions}) =
    [
        [
            "-- This file was auto-generated",
            "-- Do not edit this file as your changes may be lost!",
            intercalate " " ["module", show name, "where"],
            emptyLine
        ],
        map show imports,
        [ emptyLine ],
        map show expressions
    ]
    # concat
    # map line
    # fold


line :: String -> String
line string = string <> "\n"

emptyLine :: String 
emptyLine = ""