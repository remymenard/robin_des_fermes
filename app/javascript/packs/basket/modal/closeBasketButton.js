import { closeBasket } from '../utils/basketOpener'

export function closeBasketButton() {
  $('#cross').on('click', (e) => {
    closeBasket();
    e.preventDefault();
  })
};
