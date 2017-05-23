let creditcard;

$(document).on("turbolinks:load", () => {
  Stripe.setPublishableKey($("meta[name='stripe-key']").attr("content"));
  return creditcard.setupForm();
});

creditcard = {
  setupForm() {
    return $('#new_credit_card').submit(e => {
      $('input[type=submit]').attr('disabled', true);
      if ($('#card_number').length) {
        $("#credit-card-submit-container").css("display", "none");
        $("#credit-card-spinner").css("display", "");
        creditcard.processCard();
        return false;
      } else {
        return true;
      }
    });
  },
  processCard() {
    let card;
    card = {
      number: $('#card_number').val(),
      cvc: $('#card_code').val(),
      expMonth: $('#card_month').val(),
      expYear: $('#card_year').val(),
      name: $("#name").val()
    };
    return Stripe.createToken(card, creditcard.handleStripeResponse);
  },
  handleStripeResponse(status, response) {
    if (status === 200) {
      $("#stripe_card_token").val(response.id);
      return $("#new_credit_card").get(0).submit();
    } else {
      $("#credit-card-submit-container").css("display", "");
      $("#credit-card-spinner").css("display", "none");
      $("#stripe_error").text(response.error.message);
      return $('input[type=submit]').attr('disabled', false);
    }
  }
};
