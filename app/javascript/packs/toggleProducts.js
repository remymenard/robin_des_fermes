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


function toggleCarousel(childElement) {
  // Carousel toggle
  const parentElement = $(childElement).parents()[3];
  $(parentElement).find(".card-farm-carousel").slideToggle();
  // we toggle the link innerText too
  toggleText(childElement);
};

// function to toggle border bottom left radius
function toggleRadius(childElement) {
  const parentElement = $(childElement).parents()[3];
  $(parentElement).find(".photo").toggleClass("hide-radius-left");
};

function toggleText(element) {
  if (element.innerText.startsWith("MASQUER")) {
    element.innerText = "AFFICHER LES PRODUITS PHARES";
  } else {
    element.innerText = "MASQUER LES PRODUITS PHARES";
  }
};

