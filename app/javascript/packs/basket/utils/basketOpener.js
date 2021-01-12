const box = require('custombox');

const modalObject = {
  content: {
    speedIn: 100,
    speedOut: 90,
    effect: 'blur',
    target: '#basket',
    positionX: 'right',
    positionY: 'top',
    id: 'basket'
  },
  loader: {
    active: false
  }
};

export function openBasket() {
  const customBoxModal = new box.modal(modalObject);
  customBoxModal.open();
}

export function closeBasket() {
  box.modal.close('basket');
}

