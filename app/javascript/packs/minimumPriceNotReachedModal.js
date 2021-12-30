const box = require('custombox');

const modalObject = {
  content: {
    speedIn: 240,
    speedOut: 240,
    effect: 'rotatedown',
    target: '.minimum_price_not_reached_modal',
    positionX: 'center',
    positionY: 'center',
    id: 'minimumPriceNotReachedModal'
  },
  loader: {
    active: false
  }
};

function initProductModal () {
  $('.open-price-too-low-modal').on('click', (event) => {
    event.preventDefault();

    const customBoxModal = new box.modal(modalObject);
    customBoxModal.open();
  })

  $('.product-modal .close-button').on('click', (event) => {
    event.preventDefault();
    box.modal.close('minimumPriceNotReachedModal');
  })

  $('.product-modal .add-to-basket').on('click', () => {
    box.modal.close('minimumPriceNotReachedModal');
  })
}

document.addEventListener('DOMContentLoaded', initProductModal)
