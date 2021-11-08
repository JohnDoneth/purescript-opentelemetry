module OpenTelemetry.SDKTraceNode (
    nodeTracerProvider, 
    NodeTracerProvider, 
    addSpanProcessor,
    registerContextManager,
    registerProvider
) where

import OpenTelemetry.API.Tracer (Tracer)
import OpenTelemetry.API.Context (ContextManager)
import OpenTelemetry.SDKTraceBase (SpanProcessor)

import Prelude
import Effect (Effect)

foreign import data NodeTracerProvider :: Type

foreign import nodeTracerProvider :: Effect NodeTracerProvider

foreign import registerProvider :: NodeTracerProvider -> Effect Unit

-- | Adds a processor to process spans. This can be an exporter to export spans
-- | over HTTP or a console exporter which displays spans via `console.log`.
foreign import addSpanProcessor :: NodeTracerProvider -> SpanProcessor -> Effect Unit

-- | Register a context manager. 
-- |
-- | The context manager contains entries which allow tracing components which
-- | are tracing a single thread of execution to communicate with each other and
-- | ensure the trace is successfully created. For example, when a span is
-- | created it may be added to the context. Later, when another span is created
-- | it may use the span from the context as its parent span
-- |
-- | https://github.com/open-telemetry/opentelemetry-js-api/blob/main/docs/context.md 
foreign import registerContextManager :: NodeTracerProvider -> ContextManager -> Effect Unit