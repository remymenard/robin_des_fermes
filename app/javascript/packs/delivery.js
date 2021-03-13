require('jquery-form')

require("gasparesganga-jquery-loading-overlay")

export function initDeliverySelect() {
  $(document).on('click', '[js-user-delivery-choice-delivery]', (event) => {
    if (!$(event.currentTarget).hasClass("active")) {
      $(event.currentTarget).parent().children("[js-user-delivery-choice-takeaway]").removeClass('active')
      $(event.currentTarget).addClass('active')
      setTimeout(updateRecapCard, 300)
      setTimeout(activateConfirmButton, 300)
    }
  })

  $(document).on('click', '[js-user-delivery-choice-takeaway]', (event) => {
    if (!$(event.currentTarget).hasClass("active")) {
      $(event.currentTarget).parent().children("[js-user-delivery-choice-delivery]").removeClass('active')
      $(event.currentTarget).addClass('active')
      setTimeout(updateRecapCard, 300)
      setTimeout(activateConfirmButton, 300)
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
    },
    error: (response) => {
      console.log('Something went wrong, try again!')
      stopLoadingAnimation()
      activateConfirmButton()
    }
  });
}

function generateTotalPrice() {
  let sum = 0
  $('.farm-order-price').each((_index, element) => {
    sum += parseFloat($(element).text())
  })
  const totalPrice = sum + shippingPrice
  return totalPrice.toFixed(2).replace(".", ",");
}

let shippingPrice;

function generateShippingPrice() {
  shippingPrice = 0;

  $('.delivery-card input').each((_index, element) => {
    if (element.checked) {
      const deliveryType = $(element).val();

      const takeawayPrice = parseFloat($(element).data("takeaway").replace(",", "."));
      const deliveryPrice = parseFloat($(element).data("delivery").replace(",", "."));

      if (deliveryType === "takeaway") {
        shippingPrice += takeawayPrice;
      } else if (deliveryType === "delivery") {
        shippingPrice += deliveryPrice;
      }
    }
  })
  return shippingPrice.toFixed(2).replace(".", ",");
}

function updateRecapCard() {
  const shippingPrice = generateShippingPrice();
  const totalPrice  = generateTotalPrice();

  $('#delivery-price').text(shippingPrice)
  $('#totalPrice').text(totalPrice)
}

function activateConfirmButton() {
  let farmOrdersCount     = document.querySelectorAll('.delivery-card').length
  let userShippingChoices = document.querySelectorAll('.delivery-card input:checked').length
  let allChoicesMade      = farmOrdersCount == userShippingChoices

  if(allChoicesMade) {
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

