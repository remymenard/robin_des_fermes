require('jquery-form')

require("gasparesganga-jquery-loading-overlay")


function initDeliveryChoicesButton() {
  $(document).on('click', 'a#deliverySend', (event) => {
    event.preventDefault();
    if (!$(event.currentTarget).hasClass("active")) {
      $(event.currentTarget).parent().children("#deliveryPickup").removeClass('active')
      $(event.currentTarget).addClass('active')
      $(event.currentTarget).parent().parent().children('input').val('express')
      activateConfirmButton();
      updateRecapCard("express");
    }
  })
  $(document).on('click', 'a#deliveryPickup', (event) => {
    event.preventDefault();
    if (!$(event.currentTarget).hasClass("active")) {
      $(event.currentTarget).parent().children("#deliverySend").removeClass('active')
      $(event.currentTarget).addClass('active')
      $(event.currentTarget).parent().parent().children('input').val('takeaway')
      activateConfirmButton();
      updateRecapCard("takeaway");
    }
  })
  $('#delivery-choices').ajaxForm({
    dataType: 'json',
        success: (response) => {
          startLoadingAnimation();
          Datatrans.startPayment({
            transactionId:  response["transaction"],
            'loaded': () => {
              stopLoadingAnimation();
              activateConfirmButton();
            }
          });

        }
});
}

const takeawayPrice = parseFloat($('#delivery-cost-prices').data('takeaway'))
const expressPrice = parseFloat($('#delivery-cost-prices').data('express'))
const standardPrice = parseFloat($('#delivery-cost-prices').data('standard'))

function generateTotalPrice() {
  let sum = 0
  $('.farm-order-price').each((_index, element) => {
    sum += parseFloat($(element).text())
  })
  return sum;
}

function generateShippingPrice() {
  let sum = 0
  $('.delivery-card input').each((_index, element) => {
    const value = $(element).val();
    switch (value) {
      case "takeaway":
        sum += takeawayPrice;
      break;
      case "express":
        sum += expressPrice;
      break;
      case "standard":
        sum += standardPrice;
      break;
    }
  })
  return sum;
}

function updateRecapCard() {

  const currentPrice = generateTotalPrice();
  const shippingPrice = generateShippingPrice();
  $('#delivery-price').text(shippingPrice)
  $('#totalPrice').text(currentPrice + shippingPrice)

}

function activateConfirmButton() {
  let allInputEntered = true;
  document.querySelectorAll('.delivery-card input').forEach((element) => {
    if(element.value === "") allInputEntered = false;
  })
  if(allInputEntered) {
    $('.confirm-button').each((_index, element) => {
      $(element).prop('disabled', false)
    })
  }
}

function startLoadingAnimation() {
  $("body").LoadingOverlay("show", {
    imageColor  : "#339E72"
  });
}

function stopLoadingAnimation() {
  $("body").LoadingOverlay("hide");
}

document.addEventListener('turbolinks:load', initDeliveryChoicesButton);
