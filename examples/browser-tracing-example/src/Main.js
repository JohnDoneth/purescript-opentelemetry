"use strict";

const opentelemetry = require("@opentelemetry/api");

exports.ffiFetch = () => {
  fetch("http://localhost:8080");
};
