import {updateNavbarInfos} from '../packs/basket/utils/updateNavbarInfos';

document.addEventListener('DOMContentLoaded', () => {
  
  // list of all buttons
  const buttons = document.querySelectorAll('.add-product-to-basket');
  const modal = document.getElementById('cart-modal-container');
  const closeNotificationButton = document.getElementById('close-cart-modal');

  // add eventListener on all cart buttons
  buttons.forEach((button) => {
    button.addEventListener("click", (e) => {
      const nbProducts = getNbProducts(button);
      sendAjaxRequest(e, "POST", nbProducts);
      // show modal
      $(modal).css('display', 'block');
    });
  });

  closeNotificationButton.addEventListener("click", () => {
    $(modal).css('display', 'none');
  });

});

// this function gets the counter (nb products to add to basket)
function getNbProducts(childElement) {
  const parentElement = $(childElement).parents()[2];
  const str = $(parentElement).find(".cart-counter")[0].innerText;
  return parseInt(str);
};

function sendAjaxRequest(e, requestType, nbProducts, reloadPage = false) {
  e.preventDefault();
  const default_suffix = "increment/1";
  const new_suffix = "increment/" + nbProducts;
  let hrefPath = $(e.target).data("path").replace(default_suffix, new_suffix);
  const token = $(e.target).data("token");

  console.log($(e.target).data("path"));
  console.log(hrefPath);

  $.ajax({
    data: {
      authenticity_token: token,
    },
    url: hrefPath,
    type: requestType,
    success: (answer) => {
      if (reloadPage) {
        location.reload();
      } else {
        $("#basket").html(answer);
        updateNavbarInfos();
      }
    }
  })
};

