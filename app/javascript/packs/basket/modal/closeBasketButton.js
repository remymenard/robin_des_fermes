import { closeBasket } from '../utils/basketOpener'

export function initCloseBasketButton() {
  $('#cross').on('click', (e) => {
    closeBasket();
    e.preventDefault();
  })
};
