require('jquery-form')

require("gasparesganga-jquery-loading-overlay")


function initEvents() {
  $(document).on('click', 'a#deliverySend', (event) => {
    event.preventDefault();
    if (!$(event.currentTarget).hasClass("active")) {
      $(event.currentTarget).parent().children("#deliveryPickup").removeClass('active')
      $(event.currentTarget).addClass('active')
      $(event.currentTarget).parent().parent().children('input').val('delivery')
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
      updateRecapCard();
    }
  })
  $('#delivery-choices').ajaxForm({
    dataType: 'json',
    beforeSubmit: startLoadingAnimation,
    success: (response) => {
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
    const deliveryType = $(element).val();
    const takeawayPrice = parseFloat($(element).data("takeaway"));
    const deliveryPrice = parseFloat($(element).data("delivery"));

    if (deliveryType === "takeaway") {
      sum += takeawayPrice;
    } else if (deliveryType === "delivery") {
      sum += deliveryPrice;
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
    if(element.value === "X") allInputEntered = false;
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

document.addEventListener('turbolinks:load', initEvents);
