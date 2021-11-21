module Main where

import Prelude

import Effect (Effect)
import Effect.Console (logShow)

import Node.FS.Sync (readTextFile)
import Node.Encoding (Encoding(..))

import Parsing (parseGroups)

main :: Effect Unit
main = do
  fileData <- readTextFile UTF8 "./opentelemetry-specification/semantic_conventions/trace/database.yaml"
  logShow (parseGroups fileData)