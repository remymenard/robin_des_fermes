import { openBasket } from '../utils/basketOpener'


export function initOpenBasketButton() {
  $('.basket-div').on('click', (e) => {
    openBasket();
    e.preventDefault();
  });
}
