import { closeBasket } from '../utils/basketOpener'

$(() => {
  $('#cross').on('click', (e) => {
    closeBasket();
    e.preventDefault();
  })
});
