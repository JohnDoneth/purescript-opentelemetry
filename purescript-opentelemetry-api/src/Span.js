"use strict";

const opentelemetry = require("@opentelemetry/api");

exports.addEvent = (span) => (name) => () => span.addEvent(name);

exports.end = (span) => () => span.end();

exports.isRecording = (span) => () => span.isRecording();

exports.setAttribute = (span) => (key) => (value) => () =>
  span.setAttribute(key, value);
