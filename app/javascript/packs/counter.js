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
  let parentElement = $(item).parents()[1];
  let str = $(parentElement).find(".cart-counter")[0].innerText;
  let counter = parseInt(str);
  $(parentElement).find(".cart-counter")[0].innerText = counter + 1;
};


function decrease(item) {
  let parentElement = $(item).parents()[1];
  let str = $(parentElement).find(".cart-counter")[0].innerText;
  let counter = parseInt(str);
  if (counter > 1) {
    $(parentElement).find(".cart-counter")[0].innerText = counter - 1;
  };
};


