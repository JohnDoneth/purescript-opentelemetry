module Main where

import Data.Maybe
import Effect.Aff
import Effect.Aff.Class
import Effect.Class
import OpenTelemetry.API
import OpenTelemetry.CollectorExporter
import OpenTelemetry.Instrumentation
import OpenTelemetry.SDKTraceBase
import OpenTelemetry.SDKTraceNode
import OpenTelemetry.ZoneContext
import OpenTelemetry.InstrumentationHTTP

import Prelude

import Effect (Effect)
import Effect.Console as Console
import HTTPure as HTTPure
import OpenTelemetry.API.Span as Span
import OpenTelemetry.API.Tracer (Tracer)
import OpenTelemetry.API.Tracer as Tracer

setupTracing :: Effect Tracer
setupTracing = do
  -- Bunch of setup.
  provider <- nodeTracerProvider
  consoleExporter <- consoleExporter
  traceExporter <- collectorTraceExporter $ exporterOptions

  -- Register the console exporter, so spans will be logged to the console.
  -- This should be disabled in production.
  addSpanProcessor provider (wrapSimpleSpanProcessor consoleExporter)
  addSpanProcessor provider (wrapSimpleSpanProcessor traceExporter)

  httpInstrumentation <- httpInstrumentation

  -- Register instrumentation packages. 
  _cleanupFn <- registerInstrumentations
    { instrumentations: [ httpInstrumentation ]
    , meterProvider: Nothing
    , tracerProvider: Nothing
    }

  -- Get a tracer so we can start creating spans manually.
  getTracer "node-tracer"

corsMiddleware :: (HTTPure.Request -> HTTPure.ResponseM) -> HTTPure.Request -> HTTPure.ResponseM
corsMiddleware router request = do
  response <- router request
  pure $ response { headers = response.headers <> corsHeaders }
  where
  corsHeaders = HTTPure.header "Access-Control-Allow-Origin" "*"
    <> HTTPure.header "Access-Control-Allow-Headers" "traceparent"

tracingMiddleware :: Tracer -> (HTTPure.Request -> HTTPure.ResponseM) -> HTTPure.Request -> HTTPure.ResponseM
tracingMiddleware tracer router request = do
  Tracer.startActiveSpanAff tracer "request" $ \span -> do
    liftEffect $ Console.logShow request
    liftEffect $ Span.setAttribute span "http.method" (show request.method)
    liftEffect $ Span.setAttribute span "http.url" request.url
    liftEffect $ Span.setAttribute span "http.version" (show request.httpVersion)

    response <- router request

    liftEffect $ Span.setAttribute span "http.status_code" (show response.status)

    pure response

main :: HTTPure.ServerM
main = do
  tracer <- setupTracing
  HTTPure.serve 8080 (composedRouter tracer) $ Console.log "Server now up on port http://localhost:8080"
  where
  composedRouter tracer = corsMiddleware <<< (tracingMiddleware tracer) $ router
  router { path: [] } = HTTPure.ok "Hello, World!"
  router _ = HTTPure.response 404 "Not Found!"