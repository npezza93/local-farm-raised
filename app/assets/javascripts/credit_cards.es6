function stripeTokenHandler(token) {
  const form = $("#new_credit_card")[0];
  const hiddenInput = document.createElement("input");
  hiddenInput.setAttribute("type", "hidden");
  hiddenInput.setAttribute("name", "stripe_card_token");
  hiddenInput.setAttribute("value", token.id);
  form.appendChild(hiddenInput);

  form.submit();
}

$(document).on("turbolinks:load", () => {
  const stripe = Stripe($("meta[name='stripe-key']").attr("content"));
  const elements = stripe.elements();
  const style = {
    base: {
      color: "#32325d",
      lineHeight: "24px",
      fontFamily: "'Helvetica Neue', Helvetica, sans-serif",
      fontSmoothing: "antialiased",
      fontSize: "16px",
      "::placeholder": {
        color: "#aab7c4"
      }
    },
    invalid: {
      color: "#fa755a",
      iconColor: "#fa755a"
    }
  };
  const card = elements.create("card", {style});
  if ($("#card-element").length > 0) {
    card.mount("#card-element");
  }

  card.addEventListener("change", event => {
    const displayError = document.getElementById("card-errors");
    if (event.error) {
      displayError.textContent = event.error.message;
    } else {
      displayError.textContent = "";
    }
  });

  $(document).on("submit", "#new_credit_card", event => {
    event.preventDefault();

    stripe.createToken(card).then(result => {
      if (result.error) {
        const errorElement = document.getElementById("card-errors");
        errorElement.textContent = result.error.message;
      } else {
        stripeTokenHandler(result.token);
      }
    });
  });
});
