document.addEventListener('DOMContentLoaded', () => {
  const itemsMinus = document.querySelectorAll('.minus');
  const itemsPlus = document.querySelectorAll('.plus');

  itemsMinus.forEach((item) => {
    item.addEventListener("click", () => {
      decrease(item);
    });
  });

  itemsPlus.forEach((item) => {
    item.addEventListener("click", () => {
      increase(item);
    });
  });
});


function increase(item) {
  const parentElement = $(item).parents()[1];
  const str = $(parentElement).find(".cart-counter")[0].innerText;
  const counter = parseInt(str);
  $(parentElement).find(".cart-counter")[0].innerText = counter + 1;
};


function decrease(item) {
  const parentElement = $(item).parents()[1];
  const str = $(parentElement).find(".cart-counter")[0].innerText;
  const counter = parseInt(str);
  if (counter > 1) {
    $(parentElement).find(".cart-counter")[0].innerText = counter - 1;
  };
};


