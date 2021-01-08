var box = require('custombox');

const modal = {
  content: {
    speedIn: 100,
    speedOut: 90,
    effect: 'blur',
    target: '#basket',
    positionX: 'right',
    positionY: 'top'
  },
  loader: {
    active: false
  }
};

$(() => {
  $('#navbarDropdown').on('click', (e) => {
    openBasket();
    e.preventDefault();
  });

  $('#cross').on('click', (e) => {
    closeBasket();
    e.preventDefault();
  })
});

const openBasket = () => {
  modal.open();
}

let closeBasket = () => {
  box.modal.close();
}

export { openBasket, closeBasket };
