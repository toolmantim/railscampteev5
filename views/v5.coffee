$ ->
  # A -webkit-transition only version of:
  # http://technology.razorfish.com/2010/02/08/detecting-css-transitions-support-using-javascript/
  cssTransitionsSupported: false
  (->
      div: document.createElement('div')
      div.innerHTML: '<div style="-webkit-transition:color 1s linear;"></div>'
      cssTransitionsSupported: div.firstChild.style.webkitTransition
      delete div
  )()

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
      url: "/order"
      type: "POST"
      data: form.find("form").serialize()
      success: -> flip()
      error: (xhr, status) -> console.log(arguments...)
    }

    formInputFields.attr("disabled", "disabled")

    return false

  flip: ->
    form.addClass("flipped")
    showEnvelope() unless cssTransitionsSupported

  form.get(0).addEventListener "webkitTransitionEnd",
    ((event) -> showEnvelope() if event.propertyName is "-webkit-transform"),
    false
    
  showEnvelope: ->
    form.hide().removeClass("visible").removeClass("flipped")
    formInputFields.attr("disabled", null).attr("checked", null).attr("selected", null).val(null)
    submitButtonInner.text(form.data("original-button-text"))
    success.css({height:$("#order-form").height()}).show()
    setTimeout (-> success.addClass("unflipped")), 50
    
  success.click ->
    success.addClass("zoomed-away")
    setTimeout (-> success.hide().removeClass("unflipped").removeClass("zoomed-away")), 1000