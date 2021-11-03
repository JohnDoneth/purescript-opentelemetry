"use strict";

const { ZoneContextManager } = require('@opentelemetry/context-zone');

exports.zoneContextManager = function () {
  return new ZoneContextManager();
};
