"use strict";

const opentelemetry = require("@opentelemetry/api");

exports.getTracer = (tracerName) => () => {
  return opentelemetry.trace.getTracer(tracerName);
}