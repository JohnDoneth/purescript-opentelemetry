"use strict";

const opentelemetry = require("@opentelemetry/api");

exports.getTracer = (tracerName) => () => {
  return opentelemetry.trace.getTracer(tracerName);
};

exports.setGlobalPropagator = (propagator) => () => {
  opentelemetry.propagation.setGlobalPropagator(propagator);
};
