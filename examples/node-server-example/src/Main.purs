module Main where

import Data.Maybe
import Effect.Aff
import Effect.Aff.Class
import Effect.Class
import OpenTelemetry.API
import OpenTelemetry.CollectorExporter
import OpenTelemetry.Instrumentation
import OpenTelemetry.NodeSDK
import OpenTelemetry.SDKTraceBase
import OpenTelemetry.SDKTraceNode
import OpenTelemetry.ZoneContext
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
  
  -- Register the console exporter, so spans will be logged to the console.
  -- This should be disabled in production.
  addSpanProcessor provider (wrapSimpleSpanProcessor consoleExporter)

  -- Register the Zone context manager. This provides a consistent tracing context
  -- between async calls like calls to fetch.
  --registerContextManager provider zoneContextManager

  -- Get a tracer so we can start creating spans manually.
  getTracer "node-tracer"

corsMiddleware :: (HTTPure.Request -> HTTPure.ResponseM) -> HTTPure.Request -> HTTPure.ResponseM
corsMiddleware router request = do
  --doSomethingBefore
  response <- router request
  --doSomethingAfter
  pure response


tracingMiddleware :: Tracer -> (HTTPure.Request -> HTTPure.ResponseM) -> HTTPure.Request -> HTTPure.ResponseM
tracingMiddleware tracer router request = do

  -- liftEffect $ Tracer.startActiveSpanFFI tracer "request" $ \span -> do 
  --   Span.setAttribute span "http.method" (show request.method)

  --   Tracer.startActiveSpanFFI tracer "nested" $ \_span -> do
  --     Console.log "nested callback"
  --     liftEffect $ Span.setAttribute span "http.method" (show request.method)

  Tracer.startActiveSpan2 tracer "request" $ \span -> do 
    --liftEffect $ Console.log "callback"
    liftEffect $ Span.setAttribute span "http.method" (show request.method)

    Tracer.startActiveSpan2 tracer "nested" $ \_span -> do
      --liftEffect $ Console.log "nested callback"
      liftEffect $ Span.setAttribute span "http.method" (show request.method)

      router request


main :: HTTPure.ServerM
main = do
  tracer <- setupTracing
  HTTPure.serve 8080 (composedRouter tracer) $ Console.log "Server now up on port http://localhost:8080"
  where
    composedRouter tracer = (tracingMiddleware tracer) $ router 
    router _ = do
      HTTPure.ok "Hello, World! 2"