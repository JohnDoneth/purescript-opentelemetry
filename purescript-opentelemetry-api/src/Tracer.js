"use strict";

// const opentelemetry = require("@opentelemetry/api");

exports.startSpan = (tracer) => (name) => () => {
  return tracer.startSpan(name);
};

exports.startActiveSpan =
  (tracer) => (spanName) => (func) => () => { 
    return tracer.startActiveSpan(spanName, function(span) {
      console.log("start");
      let result = func.call(this, span)();
      span.end();
      console.log("stop")
      return result;
    });
  }

exports.startActiveSpanFFI = (tracer) => (spanName) => (func) => { 
    console.log("1")  
    return tracer.startActiveSpan(spanName, (span) => {
      console.log("2")  
      const result = func.call(this, span);
      span.end();
      return result;
    });

    console.log("3")
  }


// exports.startActiveSpanPromise =
//   (tracer) => (spanName) => (func) => () => new Promise((resolve, reject) => { 
//     return tracer.startActiveSpan(spanName, function(span) {
//       console.log("start");
//       let result = func.call(this, span)();
//       span.end();
//       console.log("stop");
//       return resolve(result);
//     });
//   })

exports.startActiveSpanEffectFnAff = (tracer) => (spanName) => (func) => function (_onError, onSuccess) {
  console.log("called")
  
  console.log({
    tracer: tracer, 
    spanName: spanName, 
    func: func
  });

  // tracer.startActiveSpan(spanName, function(span) {
  //   console.log("start");
  //   let result = func.call(this, span)();
  //   span.end();
  //   console.log("stop");
  //   onSuccess(result);
  // });

  onSuccess("42");

  return function (_cancelError, _onCancelerError, _onCancelerSuccess) {};
};