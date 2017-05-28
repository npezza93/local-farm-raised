$(document).on("click", ".cart-peek-link", (e) => {
  e.preventDefault();
  $(".cart-peek").toggleClass("hidden");
});
