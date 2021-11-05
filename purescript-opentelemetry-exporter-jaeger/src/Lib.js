"use strict";

const { JaegerExporter } = require("@opentelemetry/exporter-jaeger");

exports.jaegerExporterFFI = function (options) {
  return function () {
    return new JaegerExporter(options);
  };
};
