# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


document.addEventListener 'page:change', ->
  componentHandler.upgradeDom()
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  creditcard.setupForm()

creditcard =
  setupForm: ->
    $('#new_credit_card').submit (e) ->
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        $("#credit-card-submit-container").css("display", "none")
        $("#credit-card-spinner").css("display", "")
        creditcard.processCard()
        false
      else
        true

  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
      name: $("#name").val()
    Stripe.createToken(card, creditcard.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      $("#stripe_card_token").val(response.id)
      $("#new_credit_card").get(0).submit()
    else
      $("#credit-card-submit-container").css("display", "")
      $("#credit-card-spinner").css("display", "none")
      $("#stripe_error").text(response.error.message)
      $('input[type=submit]').attr('disabled', false)
