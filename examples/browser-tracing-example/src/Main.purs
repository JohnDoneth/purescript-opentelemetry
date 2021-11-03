module Main where

import OpenTelemetry.SDKTraceBase 
import OpenTelemetry.SDKTraceWeb

import Prelude

import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
main = do
  provider <- webTracerProvider
  consoleExporter <- consoleExporter
  
  addSpanProcessor provider (wrapSimpleSpanProcessor consoleExporter)

  let tracer = getTracer provider "example-tracer-web"

  log "🍝"
