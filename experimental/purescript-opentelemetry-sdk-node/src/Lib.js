"use strict";

const { context } = require("@opentelemetry/api");
const { NodeSDK } = require("@opentelemetry/sdk-node");
const { SimpleSpanProcessor } = require("@opentelemetry/sdk-trace-base");
const { AsyncHooksContextManager } = require("@opentelemetry/context-async-hooks");

exports.nodeSDK = (traceExporter) => () => {
  let contextManager = new AsyncHooksContextManager();

  context.setGlobalContextManager(contextManager);

  return new NodeSDK({
    spanProcessor: new SimpleSpanProcessor(traceExporter),
    contextManager: contextManager
  });
};

exports.start = function (nodeSDK) {
  return function() {
    nodeSDK.start();
  }
};
