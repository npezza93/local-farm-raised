# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:load', ->
  $("#small-cart-link").on 'click', ->
    if $("#cart-peek").css("display") == "block"
      $("#cart-peek").hide('blind', 1000);
    else
      $("#cart-peek").show('blind', 1000);
    false

$ ->
  $("#small-cart-link").on 'click', ->
    if $("#cart-peek").css("display") == "block"
      $("#cart-peek").hide('blind', 1000);
    else
      $("#cart-peek").show('blind', 1000);
    false
