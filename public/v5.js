(function(){
  $(function() {
    var _a, _b, _c, _d, img;
    // Preload dem images
    _a = []; _c = ["checkboxes.png", "reservation-ornament-left.png", "reservation-ornament-right.png", "envelope-overlay.png"];
    for (_b = 0, _d = _c.length; _b < _d; _b++) {
      img = _c[_b];
      _a.push($("<img/>").attr("src", img));
    }
    return _a;
  });
  $(function() {
    var cssTransitionsSupported, flip, form, formInputFields, showEnvelope, submitButton, submitButtonInner, success;
    // A -webkit-transition only version of:
    // http://technology.razorfish.com/2010/02/08/detecting-css-transitions-support-using-javascript/
    cssTransitionsSupported = false;
    (function() {
      var div;
      div = document.createElement('div');
      div.innerHTML = '<div style="-webkit-transition:color 1s linear;"></div>';
      cssTransitionsSupported = div.firstChild.style.webkitTransition;
      return delete div;
    })();
    form = $("#order-form");
    submitButton = form.find("button");
    submitButtonInner = submitButton.find("strong");
    formInputFields = form.find(":input");
    success = $("#order-form-success");
    $("a.order-now").click(function() {
      form.show();
      setTimeout((function() {
        return form.addClass("visible").find("input:first").focus();
      }), 50);
      return false;
    });
    form.bind("change keydown", function() {
      var _a, _b, _c, _d, _e, _f, _g, disabled, f, field, formValues, missingFields;
      formValues = {};
      _b = form.find("form").serializeArray();
      for (_a = 0, _c = _b.length; _a < _c; _a++) {
        f = _b[_a];
        (formValues[f.name] = f.value);
      }
      missingFields = (function() {
        _d = []; _f = ["attendee", "name", "sex", "size"];
        for (_e = 0, _g = _f.length; _e < _g; _e++) {
          field = _f[_e];
          !(formValues[field] == undefined ? undefined : formValues[field].length) ? _d.push(field) : null;
        }
        return _d;
      }).call(this);
      disabled = missingFields.length ? "disabled" : null;
      return submitButton.attr("disabled", disabled);
    });
    form.submit(function() {
      if (submitButton.attr("disabled")) {
        return false;
      }
      form.data("original-button-text", submitButtonInner.text());
      submitButtonInner.text("Reserving...");
      $.ajax({
        url: "/order",
        type: "POST",
        data: form.find("form").serialize(),
        success: function success() {
          return flip();
        },
        error: function error(xhr, status) {
          return console.log.apply(console, arguments);
        }
      });
      formInputFields.attr("disabled", "disabled");
      return false;
    });
    flip = function flip() {
      form.addClass("flipped");
      if (!(cssTransitionsSupported)) {
        return showEnvelope();
      }
    };
    form.get(0).addEventListener("webkitTransitionEnd", (function(event) {
      if (event.propertyName === "-webkit-transform") {
        return showEnvelope();
      }
    }), false);
    showEnvelope = function showEnvelope() {
      form.hide().removeClass("visible").removeClass("flipped");
      formInputFields.attr("disabled", null).attr("checked", null).attr("selected", null).val(null);
      submitButtonInner.text(form.data("original-button-text"));
      success.css({
        height: $("#order-form").height()
      }).show();
      return setTimeout((function() {
        return success.addClass("unflipped");
      }), 50);
    };
    return success.click(function() {
      success.addClass("zoomed-away");
      return setTimeout((function() {
        return success.hide().removeClass("unflipped").removeClass("zoomed-away");
      }), 1000);
    });
  });
})();
