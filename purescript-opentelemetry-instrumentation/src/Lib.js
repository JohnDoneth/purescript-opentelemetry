"use strict";

const { registerInstrumentations } = require('@opentelemetry/instrumentation');

exports.registerInstrumentationsFFI = (autoLoaderOptions) => () => {
  return registerInstrumentations(autoLoaderOptions);
};
