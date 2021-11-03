module Main where

import OpenTelemetry.API
import OpenTelemetry.API.Span as Span
import OpenTelemetry.API.Tracer as Tracer
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

  tracer <- getTracer provider "example-tracer-web"

  span <- Tracer.startSpan tracer "foo"
  Span.setAttribute span "key" "value"
  Span.addEvent span "Something happened!"
  Span.end span

  withSpan tracer "bar" $ \span -> do
    log "doing IO in the middle of a span"
    Span.setAttribute span "key" "value"
    Span.addEvent span "Something happened!"

  log "🍝"
