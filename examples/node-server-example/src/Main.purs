module Main where

import Prelude

import Effect (Effect)
import Effect.Console as Console
import Effect.Class
import HTTPure as HTTPure
import Data.Maybe

import OpenTelemetry.API
import OpenTelemetry.API.Span as Span
import OpenTelemetry.API.Tracer as Tracer
import OpenTelemetry.API.Tracer (Tracer)
import OpenTelemetry.Instrumentation 
import OpenTelemetry.SDKTraceBase 
import OpenTelemetry.SDKTraceNode
import OpenTelemetry.ZoneContext
import OpenTelemetry.CollectorExporter


setupTracing :: Effect Tracer
setupTracing = do
  -- Bunch of setup.
  provider <- nodeTracerProvider
  consoleExporter <- consoleExporter
  --zoneContextManager <- zoneContextManager
  --traceExporter <- collectorTraceExporter $ exporterOptions

  -- Register the console exporter, so spans will be logged to the console.
  -- This should be disabled in production.
  addSpanProcessor provider (wrapSimpleSpanProcessor consoleExporter)
  --addSpanProcessor provider (wrapSimpleSpanProcessor traceExporter)

  -- Register the Zone context manager. This provides a consistent tracing context
  -- between async calls like calls to fetch.
  --registerContextManager provider zoneContextManager

  -- Register instrumentation packages. 
  _cleanupFn <- registerInstrumentations {
    instrumentations: [],
    meterProvider: Nothing,
    tracerProvider: Nothing
  }

  -- Get a tracer so we can start creating spans manually.
  getTracer provider "example-tracer-web"

main :: HTTPure.ServerM
main = do
  tracer <- setupTracing
  HTTPure.serve 8080 (router tracer) $ Console.log "Server now up on port http://localhost:8080"
  where
    router tracer _ = do 
      --span <- liftEffect $ Tracer.startSpan tracer "hello"
      --_ <- liftEffect $ Span.end span

      Tracer.startActiveSpan tracer "nested!" $ \span -> do
        HTTPure.ok "Hello, World!"
      
      --HTTPure.ok "hello world!"