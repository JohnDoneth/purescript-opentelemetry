module Main where

import OpenTelemetry.API
import OpenTelemetry.API.Span as Span
import OpenTelemetry.API.Tracer as Tracer
import OpenTelemetry.SDKTraceBase 
import OpenTelemetry.SDKTraceWeb
import OpenTelemetry.ZoneContext
import OpenTelemetry.Instrumentation
import OpenTelemetry.InstrumentationFetch

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Data.Maybe

main :: Effect Unit
main = do
  provider <- webTracerProvider
  consoleExporter <- consoleExporter
  zoneContextManager <- zoneContextManager

  addSpanProcessor provider (wrapSimpleSpanProcessor consoleExporter)
  registerContextManager provider zoneContextManager

  fetchInstrumentation <- fetchInstrumentation

  _cleanupFn <- registerInstrumentations {
    instrumentations: [fetchInstrumentation],
    meterProvider: Nothing,
    tracerProvider: Nothing
  }

  tracer <- getTracer provider "example-tracer-web"

  -- span <- Tracer.startSpan tracer "foo"
  -- Span.setAttribute span "key" "value"
  -- Span.addEvent span "Something happened!"
  -- Span.end span

  Tracer.startActiveSpan tracer "bar" $ \span -> do
    Span.setAttribute span "key" "value"
    Span.addEvent span "Something happened!"

    Tracer.startActiveSpan tracer "nested!" $ \span -> do
      Span.setAttribute span "key" "value"
      Span.addEvent span "Something happened!"

      ffiFetch

  log "🍝"


foreign import ffiFetch :: Effect Unit