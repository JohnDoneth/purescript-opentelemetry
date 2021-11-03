module Main where

import OpenTelemetry.API
import OpenTelemetry.API.Span as Span
import OpenTelemetry.API.Tracer as Tracer
import OpenTelemetry.SDKTraceBase 
import OpenTelemetry.SDKTraceWeb
import OpenTelemetry.ZoneContext

import Prelude

import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
main = do
  provider <- webTracerProvider
  consoleExporter <- consoleExporter
  zoneContextManager <- zoneContextManager

  addSpanProcessor provider (wrapSimpleSpanProcessor consoleExporter)
  registerContextManager provider zoneContextManager

  tracer <- getTracer provider "example-tracer-web"

  -- span <- Tracer.startSpan tracer "foo"
  -- Span.setAttribute span "key" "value"
  -- Span.addEvent span "Something happened!"
  -- Span.end span

  Tracer.startActiveSpan tracer "bar" $ \span -> do
    --log "doing IO in the middle of a span"
    Span.setAttribute span "key" "value"
    Span.addEvent span "Something happened!"

    Tracer.startActiveSpan tracer "nested!" $ \span -> do
      --log "doing IO in the middle of a span"
      Span.setAttribute span "key" "value"
      Span.addEvent span "Something happened!"

  log "🍝"
