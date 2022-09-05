document.addEventListener('DOMContentLoaded', () => {
  // list of all farms (items)
  const items = document.querySelectorAll('.show-hide-best-products');

  // toggle the first element
  toggleCarousel(items[0]);

  // add eventListener on all items
  items.forEach((item) => {
    item.addEventListener("click", () => {
      toggleCarousel(item);
    });
  });
});

// function to toggle an item
const toggleCarousel = (childElement) => {
  const parentElement = $(childElement).parents()[3];
  $(parentElement).find(".card-farm-carousel").slideToggle("slow");
};
