"use strict";

// const opentelemetry = require("@opentelemetry/api");

exports.startSpan = (tracer) => (name) => () => {
  return tracer.startSpan(name);
};

exports.startActiveSpan =
  (tracer) => (spanName) => (func) => {
    return tracer.startActiveSpan(spanName, (span) => {
      let result = func.call(this, span);
      span.end();
      return result;
    });
  };
