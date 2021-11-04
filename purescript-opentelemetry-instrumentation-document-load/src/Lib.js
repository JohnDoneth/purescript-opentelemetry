"use strict";

const { DocumentLoadInstrumentation  } = require('@opentelemetry/instrumentation-document-load');

exports.documentLoadInstrumentation = function () {
  return new DocumentLoadInstrumentation();
};
