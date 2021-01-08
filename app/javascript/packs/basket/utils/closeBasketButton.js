import { closeBasket } from '../base'

$(() => {
  $('#cross').on('click', (e) => {
    closeBasket();
    e.preventDefault();
  })
});
