"use strict";

const { HttpInstrumentation } = require("@opentelemetry/instrumentation-http");

exports.httpInstrumentation = function () {
  return new HttpInstrumentation();
};
