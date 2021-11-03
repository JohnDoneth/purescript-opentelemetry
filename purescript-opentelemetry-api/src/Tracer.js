"use strict";

const opentelemetry = require("@opentelemetry/api");

exports.startSpan = (tracer) => (name) => () => {
  return tracer.startSpan(name);
};

exports.startActiveSpan = (_monad) => (tracer) => (spanName) => (func) => () => {  
  tracer.startActiveSpan(spanName, span => {
    let result = func.call(this, span)();
    span.end();
    return result;
  });
}