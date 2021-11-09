"use strict";

import { SemanticAttributes } from '@opentelemetry/semantic-conventions';

exports.w3CTraceContextPropagator = () => {
  return new W3CTraceContextPropagator();
};
