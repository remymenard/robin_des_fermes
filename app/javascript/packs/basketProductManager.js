import { openBasket, closeBasket } from './basket'

$(() => {
  const addButton = $('.add-to-basket');
  addButton.on('click', (e) => {
    e.preventDefault();
    const productId = addButton.data('productId');
    openBasket();
    console.log(productId);
  })

});
