const box = require('custombox');
require("gasparesganga-jquery-loading-overlay")

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

export async function openBasket() {
  const customBoxModal = new box.modal(modalObject);
  await customBoxModal.open();
  return customBoxModal;
}

export function closeBasket() {
  box.modal.close('basket');
}

