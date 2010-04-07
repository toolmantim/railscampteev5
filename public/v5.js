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
    return $("#order-form").submit(function() {
      $(this).find(":input").attr("disabled", "disabled");
      $(this).find("button strong").text("Reserving...");
      return false;
    });
  });
})();
