$(document).ready ->
  $.validator.addMethod 'domainFormatValidation', (value, element, params) ->
    valid_domain = /^[A-Za-z0-9][A-Za-z0-9\-_]{2,62}.ph$/
    has_consecutive_dash = /--/
    all_numeric = /^[0-9]+$/
    starts_with_dash = /^-/
    ends_with_dash = /-$/
    arr = value.split('.')
    name = arr[0]
    !has_consecutive_dash.test(name) and !all_numeric.test(name) and !starts_with_dash.test(name) and !ends_with_dash.test(name) and valid_domain.test(value)
  , "Please enter a valid domain"
  
  $('#new_transfer_request').validate
    errorPlacement: (label, element) ->
      label.addClass('error-validator-label-simple')
      element.addClass('has-input-error')
      label.insertAfter(element)
    rules:
      "transfer_request[domain]":
        required: true,
        domainFormatValidation: true
    ,
    submitHandler: (form) ->
      form.submit()