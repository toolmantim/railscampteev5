$ ->
  $("a.order-now").click ->
    form: $("#order-form")
    form.show()
    setTimeout (-> form.addClass("visible").find("input:first").focus()), 50
    
    return false

  $("#order-form").submit ->
    return false
