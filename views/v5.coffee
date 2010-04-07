$ ->
  form: $("#order-form")
  submitButton: form.find("button")
  submitButtonInner: submitButton.find("strong")
  formInputFields: form.find(":input")
  success: $("#order-form-success")

  $("a.order-now").click ->
    form.show()
    setTimeout (-> form.addClass("visible").find("input:first").focus()), 50
    return false

  form.bind "change keydown", ->
    formValues: {}
    (formValues[f.name]: f.value) for f in form.find("form").serializeArray()

    missingFields: field for field in ["attendee", "name", "sex", "size"] when !formValues[field]?.length

    disabled: if missingFields.length then "disabled" else null
    
    submitButton.attr("disabled", disabled)

  form.submit ->
    return false if submitButton.attr("disabled")
    form.data("original-button-text", submitButtonInner.text())
    submitButtonInner.text("Reserving...")
    
    $.ajax {
      url: "/order",
      type: "POST",
      data: form.find("form").serialize(),
      success: -> form.addClass("flipped"),
      error: (xhr, status) -> console.log(arguments...)
    }

    formInputFields.attr("disabled", "disabled")

    return false

  form.get(0).addEventListener("webkitTransitionEnd",
    ((event) -> 
      if event.propertyName is "-webkit-transform"
        form.hide().removeClass("visible").removeClass("flipped")
        formInputFields.attr("disabled", null).attr("checked", null).attr("selected", null).val(null)
        submitButtonInner.text(form.data("original-button-text"))
        success.css({height:$("#order-form").height()}).show()
        setTimeout (-> success.addClass("unflipped")), 50
    ), false)

  success.click ->
    success.addClass("zoomed-away")
    setTimeout (-> success.hide().removeClass("unflipped").removeClass("zoomed-away")), 1000