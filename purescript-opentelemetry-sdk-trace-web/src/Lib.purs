module OpenTelemetry.SDKTraceWeb (
    webTracerProvider, 
    WebTracerProvider, 
    addSpanProcessor,
    getTracer,
    registerContextManager
) where

import OpenTelemetry.API.Tracer (Tracer)
import OpenTelemetry.API.Context (ContextManager)
import OpenTelemetry.SDKTraceBase (SpanProcessor)

import Prelude
import Effect (Effect)

foreign import data WebTracerProvider :: Type

foreign import webTracerProvider :: Effect WebTracerProvider

-- | Adds a processor to process spans. This can be an exporter to export spans
-- | over HTTP or a console exporter which displays spans via `console.log`.
foreign import addSpanProcessor :: WebTracerProvider -> SpanProcessor -> Effect Unit

-- | Returns a global tracer by string key.
foreign import getTracer :: WebTracerProvider -> String -> Effect Tracer

-- | Register a context manager. 
-- |
-- | The context manager contains entries which allow tracing components which
-- | are tracing a single thread of execution to communicate with each other and
-- | ensure the trace is successfully created. For example, when a span is
-- | created it may be added to the context. Later, when another span is created
-- | it may use the span from the context as its parent span
-- |
-- | https://github.com/open-telemetry/opentelemetry-js-api/blob/main/docs/context.md 
foreign import registerContextManager :: WebTracerProvider -> ContextManager -> Effect Unit