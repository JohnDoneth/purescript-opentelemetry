module OpenTelemetry.SDKTraceBase.Span where

import Prelude

-- readonly name: string;
-- readonly kind: SpanKind;
-- readonly spanContext: () => SpanContext;
-- readonly parentSpanId?: string;
-- readonly startTime: HrTime;
-- readonly endTime: HrTime;
-- readonly status: SpanStatus;
-- readonly attributes: SpanAttributes;
-- readonly links: Link[];
-- readonly events: TimedEvent[];
-- readonly duration: HrTime;
-- readonly ended: boolean;
-- readonly resource: Resource;
-- readonly instrumentationLibrary: InstrumentationLibrary;