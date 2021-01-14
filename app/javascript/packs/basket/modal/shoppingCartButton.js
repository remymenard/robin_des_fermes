import { openBasket } from '../utils/basketOpener'


export function initOpenBasketButton() {
  $('#navbarDropdown').on('click', (e) => {
    openBasket();
    e.preventDefault();
  });
}
