"use strict";

const { NodeTracerProvider } = require("@opentelemetry/sdk-trace-node");

exports.nodeTracerProvider = function () {
  return new NodeTracerProvider();
};

exports.addSpanProcessor = function (webTracerProvider) {
  return function (spanProcessor) {
    return function () {
      webTracerProvider.addSpanProcessor(spanProcessor);
    };
  };
};

exports.getTracer = function (webTracerProvider) {
  return function (text) {
    return function () {
      return webTracerProvider.getTracer(text);
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
