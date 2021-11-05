"use strict";

const { CollectorTraceExporter } = require("@opentelemetry/exporter-collector");

exports.collectorTraceExporterFFI = function (options) {
  return function () {
    return new CollectorTraceExporter(options);
  };
};
