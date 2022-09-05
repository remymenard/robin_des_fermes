document.addEventListener('DOMContentLoaded', () => {
  // list of all carousels (items)
  const items = document.querySelectorAll('.show-hide-best-products');
  
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
