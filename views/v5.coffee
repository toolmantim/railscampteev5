$ ->
  $("a.order-now").click ->
    form: $("#order-form")
    form.show()
    setTimeout (-> form.addClass("visible").find("input:first").focus()), 50
    
    return false

  $("#order-form").submit ->
    form: $(this)
  
    form.find(":input").attr("disabled", "disabled")
    form.data("original-button-text", form.find("button strong").text())
    form.find("button strong").text("Reserving...")
  
    setTimeout (-> form.addClass("flipped")), 2000
  
    return false

  $("#order-form").get(0).addEventListener("webkitTransitionEnd",
    ((event) -> 
      if event.propertyName is "-webkit-transform"
        form: $(event.srcElement)
        form.hide().removeClass("visible").removeClass("flipped")
        form.find(":input").attr("disabled", null).attr("checked", null).attr("selected", null).val(null)
        form.find("button strong").text(form.data("original-button-text"))
        
        success: $("#order-form-success")
        success.css({height:$("#order-form").height()}).show()
        setTimeout (-> success.addClass("unflipped")), 50
    ),
    false)

  $("#order-form-success").click ->
    $(this).fadeOut 300, (-> $(this).removeClass("unflipped"))