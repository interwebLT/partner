# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@showEditContact = () ->
  $('#registrant-contact').removeClass('active')
  $('#registrant-contact-edit').addClass('active')

@hideEditContact = () ->
  $('#registrant-contact').addClass('active')
  $('#registrant-contact-edit').removeClass('active')