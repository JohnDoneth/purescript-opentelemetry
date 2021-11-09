"use strict";

const {
  B3Propagator,
  B3InjectEncoding,
} = require("@opentelemetry/propagator-b3");

exports.b3PropogatorMultiHeader = function () {
  return new B3Propagator({ injectEncoding: B3InjectEncoding.MULTI_HEADER });
};

exports.b3PropogatorSingleHeader = function () {
  return new B3Propagator();
};
