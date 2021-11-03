"use strict";

const opentelemetry = require("@opentelemetry/api");

exports.trace = function () {
  return opentelemetry.trace;
};
