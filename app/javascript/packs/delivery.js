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
        transactionId: response["transaction"],
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
    sum += parseFloat($(element).text().replace(",", "."))
  })
  const totalPrice = sum + shippingPrice
  return totalPrice.toFixed(2).replace(".", ",");
}

let shippingPrice;
let shippingPriceNotCompanion;

function generateShippingPrice() {
  shippingPrice = 0;
  shippingPriceNotCompanion = 0;

  $('.delivery-card input').each((_index, element) => {
    if (element.checked) {
      const deliveryType = $(element).val();

      const takeawayPrice = parseFloat($(element).data("takeaway").replace(",", "."));
      const deliveryPrice = parseFloat($(element).data("delivery").replace(",", "."));

      if (deliveryType === "takeaway") {
        shippingPrice += takeawayPrice;
      } else if (deliveryType === "delivery") {
        shippingPrice += deliveryPrice;
        shippingPriceNotCompanion += parseFloat($(element).data("deliveryNotCompanion").replace(",", "."));
      }
    }
  })
  return shippingPrice.toFixed(2).replace(".", ",");
}

function updateRecapCard() {
  const shippingPrice = generateShippingPrice();
  const totalPrice = generateTotalPrice();

  if ($('.companion-economy-message').length) {
    if (shippingPriceNotCompanion === 0) {
      $('.companion-economy-message').addClass('d-none');
    } else {
      $('.companion-economy-message').removeClass('d-none');
    }
    $('#price-not-companion').text(shippingPriceNotCompanion.toFixed(2).replace(".", ","));
  }
  $('#delivery-price').text(shippingPrice)
  $('#totalPrice').text(totalPrice)
}

function activateConfirmButton() {
  let farmOrdersCount = document.querySelectorAll('.delivery-card').length
  let userShippingChoices = document.querySelectorAll('.delivery-card input:checked').length
  let allChoicesMade = farmOrdersCount == userShippingChoices

  if (allChoicesMade) {
    $('.confirm-button').each((_index, element) => {
      $(element).prop('disabled', false)
    })
  }
}

function startLoadingAnimation() {
  $("body").LoadingOverlay("show", {
    imageColor: "#339E72"
  });
}

function stopLoadingAnimation() {
  $("body").LoadingOverlay("hide");
}
