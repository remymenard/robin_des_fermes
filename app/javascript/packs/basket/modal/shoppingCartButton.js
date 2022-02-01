import { openBasket } from '../utils/basketOpener'

export function initOpenBasketButton() {
  $('.basket-div').on('click', (e) => {
    openBasket();
    e.preventDefault();

    // SEND MIXPANEL EVENT
    const token = $(e.target).data("token");
    $.ajax({
      data: {
        authenticity_token: token,
      },
      url: "/basket/mixpanel/open_basket",
      type: "POST"
    })
  });
}
