"use strict";

const { UserInteractionInstrumentation } = require('@opentelemetry/instrumentation-user-interaction');

exports.userInteractionInstrumentation = function () {
  return new UserInteractionInstrumentation();
};
