const box = require('custombox');

const modalObject = {
  content: {
    speedIn: 240,
    speedOut: 240,
    effect: 'rotatedown',
    target: '.product-modal',
    positionX: 'center',
    positionY: 'center',
    id: 'productModal'
  },
  loader: {
    active: false
  }
};

function initProductModal () {
  $('.card-product').on('click', (event) => {
    event.preventDefault();
    if($(event.target).is("button")) return;
    const product = event.currentTarget;
    const dataElement = $(product).children('#product-data');
    console.log(product)
    console.log(dataElement)
    const imageUrl = dataElement.data('imageUrl')
    console.log(imageUrl)
    const name = dataElement.data('name')
    const unit = dataElement.data('unit')
    const price = dataElement.data('price')
    const currency = dataElement.data('currency')
    const description = dataElement.data('description')
    const ingredients = dataElement.data('ingredients')
    const addUrl = $(product).find('.add-to-basket').data('path')
    const token = $(product).find('.add-to-basket').data('token')
    $('.product-modal .product-image').attr('src', imageUrl);
    $('.product-modal .unit').text(unit);
    $('.product-modal h1').text(name)
    $('.product-modal .price').text(price)
    $('.product-modal .currency').text(currency)
    $('.product-modal .description').text(description)
    $('.product-modal .ingredients').text(ingredients)
    $('.product-modal .add-to-basket').attr('data-token', token)
    $('.product-modal .add-to-basket').attr('data-path', addUrl)

    const customBoxModal = new box.modal(modalObject);
    customBoxModal.open();
  })

  $('.product-modal #cross').on('click', (event) => {
    event.preventDefault();
    box.modal.close('productModal');
  })

  $('.product-modal .add-to-basket').on('click', () => {
    box.modal.close('productModal');
  })
}

document.addEventListener('DOMContentLoaded', initProductModal)
