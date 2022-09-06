document.addEventListener('DOMContentLoaded', () => {
  // list of all carousels (items)
  const items = document.querySelectorAll('.show-hide-best-products');

  // add eventListener on all items
  items.forEach((item) => {
    item.addEventListener("click", () => {
      toggleCarousel(item);
      toggleRadius(item);
    });
  });
});

// function to toggle an item
function toggleCarousel(childElement) {
  const parentElement = $(childElement).parents()[3];
  $(parentElement).find(".card-farm-carousel").slideToggle("slow");
};

// function to toggle border bottom left radius
function toggleRadius(childElement) {
  const parentElement = $(childElement).parents()[3];
  $(parentElement).find(".photo").toggleClass("hide-radius-left");
};
