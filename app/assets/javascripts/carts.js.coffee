# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:load', ->
  autosize($("#product-desc-field"))

  if $("#product-desc-field").length > 0
    $("#product-desc-field").css("height", (25+$("#product-desc-field")[0].scrollHeight)+"px")

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

  # if $("#product-desc-field")
  #   $("#product-desc-field").css("height", (25+$("#product-desc-field")[0].scrollHeight)+"px")

  autosize($("#product-desc-field"))
