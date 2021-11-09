"use strict";

const { W3CTraceContextPropagator } = require("@opentelemetry/core");

exports.w3CTraceContextPropagator = () => {
  return new W3CTraceContextPropagator();
};
