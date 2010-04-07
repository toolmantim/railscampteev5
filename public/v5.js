(function(){
  $(function() {
    $("a.order-now").click(function() {
      var form;
      form = $("#order-form");
      form.show();
      setTimeout((function() {
        return form.addClass("visible").find("input:first").focus();
      }), 50);
      return false;
    });
    $("#order-form").submit(function() {
      var form;
      form = $(this);
      form.find(":input").attr("disabled", "disabled");
      form.data("original-button-text", form.find("button strong").text());
      form.find("button strong").text("Reserving...");
      setTimeout((function() {
        return form.addClass("flipped");
      }), 2000);
      return false;
    });
    $("#order-form").get(0).addEventListener("webkitTransitionEnd", (function(event) {
      var form, success;
      if (event.propertyName === "-webkit-transform") {
        form = $(event.srcElement);
        form.hide().removeClass("visible").removeClass("flipped");
        form.find(":input").attr("disabled", null).attr("checked", null).attr("selected", null).val(null);
        form.find("button strong").text(form.data("original-button-text"));
        success = $("#order-form-success");
        success.css({
          height: $("#order-form").height()
        }).show();
        return setTimeout((function() {
          return success.addClass("unflipped");
        }), 50);
      }
    }), false);
    return $("#order-form-success").click(function() {
      var success;
      success = $(this);
      success.addClass("zoomed-away");
      return setTimeout((function() {
        return success.hide().removeClass("unflipped").removeClass("zoomed-away");
      }), 1000);
    });
  });
})();
