import {updateNavbarInfos} from '../packs/basket/utils/updateNavbarInfos';

document.addEventListener('DOMContentLoaded', () => {
  // list of all buttons
  const buttons = document.querySelectorAll('.add-product-to-basket');

  // add eventListener on all cart buttons
  buttons.forEach((button) => {
    button.addEventListener("click", (e) => {
      const nbProducts = getNbProducts(button);
      Array.from({ length: nbProducts }, () => {
        sendAjaxRequest(e, "POST");
      });
    });
  });
});

// this function gets the counter (nb products to add to basket)
function getNbProducts(childElement) {
  const parentElement = $(childElement).parents()[2];
  const str = $(parentElement).find(".cart-counter")[0].innerText;
  return parseInt(str);
};

function sendAjaxRequest(e, requestType, reloadPage = false) {
  e.preventDefault();
  const hrefPath = $(e.target).data("path");
  const token = $(e.target).data("token");
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

