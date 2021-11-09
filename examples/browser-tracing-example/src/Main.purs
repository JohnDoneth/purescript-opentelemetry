module Main where

import OpenTelemetry.API
import OpenTelemetry.API.Span as Span
import OpenTelemetry.API.Tracer as Tracer
import OpenTelemetry.API.Tracer (Tracer)
import OpenTelemetry.Core
import OpenTelemetry.SDKTraceBase
import OpenTelemetry.SDKTraceWeb
import OpenTelemetry.ZoneContext
import OpenTelemetry.Instrumentation
import OpenTelemetry.InstrumentationFetch
import OpenTelemetry.InstrumentationUserInteraction
import OpenTelemetry.InstrumentationDocumentLoad
import OpenTelemetry.CollectorExporter
import OpenTelemetry.B3Propagator

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Data.Maybe
import Data.Tuple

foreign import ffiFetch :: Effect Unit

setupTracing :: Effect Tracer
setupTracing = do
  -- Bunch of setup.
  provider <- webTracerProvider
  consoleExporter <- consoleExporter
  zoneContextManager <- zoneContextManager
  fetchInstrumentation <- fetchInstrumentation
  userInteractionInstrumentation <- userInteractionInstrumentation
  documentLoadInstrumentation <- documentLoadInstrumentation
  traceExporter <- collectorTraceExporter $ exporterOptions

  -- Register the console exporter, so spans will be logged to the console.
  -- This should be disabled in production.
  addSpanProcessor provider (wrapSimpleSpanProcessor consoleExporter)
  addSpanProcessor provider (wrapSimpleSpanProcessor traceExporter)

  -- Register the Zone context manager. This provides a consistent tracing context
  -- between async calls like calls to fetch.
  registerContextManager provider zoneContextManager

  _ <- setGlobalPropagator <$> w3CTraceContextPropagator

  -- Register instrumentation packages. 
  _cleanupFn <- registerInstrumentations $ autoLoaderOptions
    { instrumentations =
        [
          -- The fetch instrumentation adds detailed tracing to
          -- requests/responses from the browser using the `fetch` API.
          fetchInstrumentation
        , documentLoadInstrumentation
        , userInteractionInstrumentation
        ]
    }

  -- Get a tracer so we can start creating spans manually.
  getTracer "example-tracer-web"

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

