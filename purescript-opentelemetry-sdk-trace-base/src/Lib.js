"use strict";

const { 
    BasicTracerProvider,
    ConsoleSpanExporter  
} = require('@opentelemetry/sdk-trace-base');

exports.registerBasicTracerProvider = function () {
    new BasicTracerProvider().register();
};

exports.consoleExporter = function () {
    return new ConsoleSpanExporter();
};

exports.wrapSimpleSpanProcessor = function(exporter) {
    return new SimpleSpanProcessor(exporter);
}