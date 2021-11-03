"use strict";

const { WebTracerProvider } = require('@opentelemetry/sdk-trace-web');

exports.webTracerProvider = function () {
    return new WebTracerProvider();
};

exports.addSpanProcessor = function (webTracerProvider) {
    return function (spanProcessor) {
        return function () {
            webTracerProvider.addSpanProcessor(spanProcessor);
        }
    }
};

exports.getTracer = function (webTracerProvider) {
    return function (text) {
        return function () {
            return webTracerProvider.getTracer(text);
        }
    }
}