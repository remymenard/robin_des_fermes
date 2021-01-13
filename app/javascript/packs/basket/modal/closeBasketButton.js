import { closeBasket } from '../utils/basketOpener'

export function initCloseBasketButton() {
  $('#basket').on('click', '#cross, .continue-button', (e) => {
    closeBasket();
    e.preventDefault();
  })
};
