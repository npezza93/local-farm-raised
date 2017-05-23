$(document).on("turbolinks:load", () => {
  $("#small-cart-link").on("click", () => {
    if ($("#cart-peek").css("display") == "block") {
      $("#cart-peek").hide("blind", 1000);
    } else {
      $("#cart-peek").show("blind", 1000);
    }
  });
});
