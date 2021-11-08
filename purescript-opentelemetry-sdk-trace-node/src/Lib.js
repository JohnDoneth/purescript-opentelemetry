"use strict";

const { NodeTracerProvider } = require("@opentelemetry/sdk-trace-node");

// REMOVE
const { AsyncHooksContextManager } = require("@opentelemetry/context-async-hooks");
//

exports.nodeTracerProvider = function () {
  const provider = new NodeTracerProvider();
  provider.register();

  // REMOVE
  provider.register({contextManager: new AsyncHooksContextManager()});
  console.log("registered hooks context manager");
  //

  return provider;
};

exports.registerProvider = (provider) => () => {
  provider.register();
}

exports.addSpanProcessor = function (webTracerProvider) {
  return function (spanProcessor) {
    return function () {
      webTracerProvider.addSpanProcessor(spanProcessor);
    };
  };
};

exports.registerContextManager = function (webTracerProvider) {
  return function (contextManager) {
    return function () {
      return webTracerProvider.register({
        contextManager: contextManager,
      });
    };
  };
};
