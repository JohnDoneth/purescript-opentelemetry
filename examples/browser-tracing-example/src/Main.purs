module Main where

import OpenTelemetry.API
import OpenTelemetry.API.Span as Span
import OpenTelemetry.API.Tracer as Tracer
import OpenTelemetry.API.Tracer (Tracer)
import OpenTelemetry.SDKTraceBase 
import OpenTelemetry.SDKTraceWeb
import OpenTelemetry.ZoneContext
import OpenTelemetry.Instrumentation
import OpenTelemetry.InstrumentationFetch

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Data.Maybe

foreign import ffiFetch :: Effect Unit

setupTracing :: Effect Tracer
setupTracing = do
  -- Bunch of setup.
  provider <- webTracerProvider
  consoleExporter <- consoleExporter
  zoneContextManager <- zoneContextManager
  fetchInstrumentation <- fetchInstrumentation

  -- Register the console exporter, so spans will be logged to the console.
  -- This should be disabled in production.
  addSpanProcessor provider (wrapSimpleSpanProcessor consoleExporter)

  -- Register the Zone context manager. This provides a consistent tracing context
  -- between async calls like calls to fetch.
  registerContextManager provider zoneContextManager

  -- Register instrumentation. The fetch instrumentation adds detailed tracing to
  -- requests/responses from the browser using the `fetch` API.
  _cleanupFn <- registerInstrumentations {
    instrumentations: [fetchInstrumentation],
    meterProvider: Nothing,
    tracerProvider: Nothing
  }

  -- Get a tracer so we can start creating spans manually.
  getTracer provider "example-tracer-web"

main :: Effect Unit
main = do
  tracer <- setupTracing

  Tracer.startActiveSpan tracer "bar" $ \span -> do
    Span.setAttribute span "key" "value"
    Span.addEvent span "Something happened!"

    Tracer.startActiveSpan tracer "nested!" $ \span -> do
      Span.setAttribute span "key" "value"
      Span.addEvent span "Something else happened!"

      -- Make a fetch request to test the fetch instrumentation using JavaScript FFI.
      -- You'd likely want to pull in a library to do this in your own project.
      ffiFetch

