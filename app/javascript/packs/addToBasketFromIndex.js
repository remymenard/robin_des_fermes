import {updateNavbarInfos} from '../packs/basket/utils/updateNavbarInfos';

document.addEventListener('DOMContentLoaded', () => {
  
  // list of all buttons
  const buttons = document.querySelectorAll('.add-product-to-basket');
  const basketModal = document.getElementById('basket-modal-container');
  const closeButton = document.getElementById('close-basket-modal');

  // add eventListener on all cart buttons
  buttons.forEach((button) => {
    button.addEventListener("click", (e) => {

      //nb products to add to basket
      const nbProducts = getNbProducts(button);

      // basket, route replacement :
      // /basket/order_line_items/product_id/increment/1 replaced by
      // /basket/order_line_items/product_id/increment/nbProducts
      sendAjaxRequest(e, "POST", nbProducts, "increment", "#basket", "");

      // basket modal, route replacement :
      // /basket/order_line_items/product_id/increment/1 replaced by
      // /basket/order_line_items/product_id/basket_modal/nbProducts
      sendAjaxRequest(e, "POST", nbProducts, "basket_modal", "#basket-modal-container", basketModal);

    });
  });
  
  // event to close when click outside of basket modal
  window.onclick = function() {
    closeWindow(basketModal);
  };

  // event to close when click on close button
  if (closeButton) {
    closeButton.onclick = function() {
      closeWindow(basketModal);
    };
  }

});

// this function gets the counter (nb products to add to basket)
function getNbProducts(childElement) {
  const parentElement = $(childElement).parents()[2];
  const str = $(parentElement).find(".cart-counter")[0].innerText;
  return parseInt(str);
};

function closeWindow(window) {
    window.style.display = "none";
};

function sendAjaxRequest(e, requestType, nbProducts, replaceBy, id, modal) {
  e.preventDefault();
  const default_suffix = 'increment/1';
  const new_suffix = `${replaceBy}/${nbProducts}`;

  const hrefPath = $(e.target).data("path").replace(default_suffix, new_suffix);
  const token = $(e.target).data("token");
  
  $.ajax({
    data: {
      authenticity_token: token,
    },
    url: hrefPath,
    type: requestType,
    success: (answer) => {
        if (modal == "") {
          $(id).html(answer);
          updateNavbarInfos();
        } else {
          $(id).html(answer);
          $(modal).css('display', 'flex');
        }
    }
  })
};

