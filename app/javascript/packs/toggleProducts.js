document.addEventListener('DOMContentLoaded', () => {
  const list = document.querySelectorAll('.show-hide-best-products');
  list.forEach((item) => {
    item.addEventListener("click", () => {
      const parent = $(item).parents()[3];
      $(parent).find(".card-farm-carousel").toggleClass('toggle-carrousel');
    });
  });
});
