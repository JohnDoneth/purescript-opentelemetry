"use strict";

const { OTLPTraceExporter } = require("@opentelemetry/exporter-otlp-http");

exports.newOTLPHTTPExporterFFI = function (options) {
  return function () {
    return new OTLPTraceExporter(options);
  };
};
