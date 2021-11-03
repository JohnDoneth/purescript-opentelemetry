module OpenTelemetry.API.Span where

import Prelude

import Effect (Effect)
import Data.Maybe

-- | An interface that represents a span. A span represents a single operation
-- | within a trace. Examples of span might include remote procedure calls or a
-- | in-process function calls to sub-components. A Trace has a single,
-- | top-level "root" Span that in turn may have zero or more child Spans, which
-- | in turn may have children.
-- |
-- | Spans are created by the Tracer.startSpan method.
foreign import data Span :: Type

-- | Adds an event to the Span.
-- | https://open-telemetry.github.io/opentelemetry-js-api/interfaces/span.html#addevent
-- |
-- | Takes a span and the name of the event.
foreign import addEvent :: 
    Span 
    -> String 
    -> Effect Unit

-- | Marks the end of Span execution.
-- | https://open-telemetry.github.io/opentelemetry-js-api/interfaces/span.html#end
foreign import end :: 
    Span
    -> Effect Unit

-- | Returns the flag whether this span will be recorded.
foreign import isRecording :: 
    Span 
    -> Boolean -- ^ true if this Span is active and recording information like events with the AddEvent operation and attributes using setAttributes.
    
-- | UNSET: The default status.
-- | OK: The operation has been validated by an Application developer or Operator to have completed successfully.
-- | ERROR: The operation contains an error.
data SpanStatusCode = UNSET | OK | ERROR

-- | code: The status code of this message.
-- | message: A developer-facing error message.
type SpanStatus = {
    code :: SpanStatusCode,
    message :: Maybe String
}

-- | Sets a status to the span. If used, this will override the default Span
-- | status. Default is SpanStatusCode.UNSET. SetStatus overrides the value of
-- | previous calls to SetStatus on the Span.
--foreign import setStatus :: Span -> SpanStatus -> Effect ()


foreign import setAttribute :: Span -> String -> String -> Effect Unit