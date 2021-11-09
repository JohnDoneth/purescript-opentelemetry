"use strict";

const {
  FetchInstrumentation,
} = require("@opentelemetry/instrumentation-fetch");

exports.fetchInstrumentation = function () {
  return new FetchInstrumentation({
    propagateTraceHeaderCorsUrls: /.*/gim,
  });
};
