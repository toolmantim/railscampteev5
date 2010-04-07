$ ->
  $("a.order-now").click ->
    form: $("#order-form")
    form.show()
    setTimeout (-> form.addClass("visible").find("input:first").focus()), 50
    
    return false

  $("#order-form").submit ->
    $(this).find(":input").attr("disabled", "disabled")
    $(this).find("button strong").text("Reserving...")
  
    return false
