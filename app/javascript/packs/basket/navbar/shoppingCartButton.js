import { openBasket } from '../base'

$(() => {
  $('#navbarDropdown').on('click', (e) => {
    openBasket();
    e.preventDefault();
  });
});
