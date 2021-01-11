import {openBasket} from './base'
import {getAddProductAnswer} from './utils/requestsManager'

$(() => {
  $('.add-to-basket').on('click', (e) => {
    getAddProductAnswer();
    openBasket();
    e.preventDefault();
  })
});
