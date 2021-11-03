"use strict";

const opentelemetry = require("@opentelemetry/api");

exports.startSpan = (tracer) => (name) => () => {
  return tracer.startSpan(name);
};