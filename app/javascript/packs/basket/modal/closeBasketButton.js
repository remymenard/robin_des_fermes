import { closeBasket } from '../utils/basketOpener'

export function initCloseBasketButton() {
  $('#cross, .continue-button').on('click', (e) => {
    closeBasket();
    e.preventDefault();
  })
};
