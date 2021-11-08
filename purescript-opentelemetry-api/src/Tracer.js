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
    console.log("start");
    let x = tracer.startActiveSpan(spanName, (span) => {
      //console.log("before call");
      const result = func(span);
     
      console.log({result: result});
      //span.end();
      return result;
    });

    console.log("end");

    return x;
  }


// startActiveSpanPromise :: Tracer -> String -> (callback -> Promise a) -> Promise a
// (Span -> Effect (Promise a))
// -> Promise a
exports.startActiveSpanPromise = (tracer) => (spanName) => (func) => { 
  return Promise.resolve(
    tracer.startActiveSpan(spanName, (span) => {
      return Promise.resolve(func(span)()).then(function(v) {
        span.end();
        return v
      });
    })
  );

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