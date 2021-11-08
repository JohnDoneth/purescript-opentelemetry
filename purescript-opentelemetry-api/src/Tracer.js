"use strict";

// const opentelemetry = require("@opentelemetry/api");

exports.startSpan = (tracer) => (name) => () => {
  return tracer.startSpan(name);
};

exports.startActiveSpan = (tracer) => (spanName) => (func) => () => {
  return tracer.startActiveSpan(spanName, function (span) {
    const result = func.call(this, span)();
    span.end();
    return result;
  });
};

exports.startActiveSpanPromise = (tracer) => (spanName) => (func) =>
  Promise.resolve(
    tracer.startActiveSpan(spanName, (span) =>
      Promise.resolve(func(span)()).then(function (v) {
        span.end();
        return v;
      })
    )
  );
