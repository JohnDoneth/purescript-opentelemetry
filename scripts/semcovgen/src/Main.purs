module Main where

import Prelude
import Repr.Groups

import Codegen (generateModule)
import Data.Either (Either(..))
import Data.Foldable (fold, foldM)
import Data.Traversable (sequence, traverse)
import Effect (Effect)
import Effect.Console (log, logShow)
import Effect.Exception (throw)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)
import Node.Path (FilePath)
import Parsing (parseGroups)
import Data.String.Common
import Data.String.Pattern

localFiles =
  [ "./opentelemetry-specification/semantic_conventions/trace/aws/lambda.yaml"
  , "./opentelemetry-specification/semantic_conventions/trace/instrumentation/aws-sdk.yml"
  , "./opentelemetry-specification/semantic_conventions/trace/database.yaml"
  , "./opentelemetry-specification/semantic_conventions/trace/exception.yaml"
  , "./opentelemetry-specification/semantic_conventions/trace/faas.yaml"
  , "./opentelemetry-specification/semantic_conventions/trace/general.yaml"
  , "./opentelemetry-specification/semantic_conventions/trace/http.yaml"
  , "./opentelemetry-specification/semantic_conventions/trace/messaging.yaml"
  , "./opentelemetry-specification/semantic_conventions/trace/rpc.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/cloud_provider/aws/ecs.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/cloud_provider/aws/eks.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/cloud_provider/aws/logs.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/cloud.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/container.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/deployment_environment.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/device.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/faas.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/host.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/k8s.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/os.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/process.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/service.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/telemetry.yaml"
  , "./opentelemetry-specification/semantic_conventions/resource/webengine.yaml"
  ]

readGroups :: FilePath -> Effect Groups
readGroups filepath = do
  log $ "Reading " <> (replace (Pattern "./opentelemetry-specification/semantic_conventions/") (Replacement "") filepath)
  fileData <- readTextFile UTF8 filepath

  case (parseGroups fileData) of
    Left error -> throw ("Could not parse file: " <> error)
    Right groups -> pure groups

readGroupsCombined :: Array FilePath -> Effect Groups
readGroupsCombined files = do
  groups :: Array Groups <- traverse readGroups files
  pure $ fold groups

main :: Effect Unit
main = do
  -- fileData <- readTextFile UTF8 "./opentelemetry-specification/semantic_conventions/trace/database.yaml"
  groups <- readGroupsCombined localFiles
  logShow groups

  logShow $ generateModule groups

