import { openBasket } from '../utils/basketOpener'

$(() => {
  $('#navbarDropdown').on('click', (e) => {
    openBasket();
    e.preventDefault();
  });
});
