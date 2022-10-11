import {updateNavbarInfos} from '../packs/basket/utils/updateNavbarInfos';
require("gasparesganga-jquery-loading-overlay");

document.addEventListener('DOMContentLoaded', () => {

  // add eventListener on close button
  const closePopup = document.getElementById("popupclose");
  closePopup.onclick = function() {
    $("#overlay").removeClass('show');
    $("#popup").removeClass('show');
  };

  // add eventListener on all cart buttons
  const buttons = document.querySelectorAll('.add-product-to-basket');
  buttons.forEach((button) => {
    button.addEventListener("click", (e) => {
      const nbProducts = getNbProducts(button);
      // run main ajax request
      sendAjaxRequest(e, nbProducts);
    });
  });
});

function sendAjaxRequest(e, nbProducts) {
  e.preventDefault();
  $(e.target).LoadingOverlay("show", { imageColor: "#339E72" });

  // route replacement with correct amount of products to add to basket
  // /basket/order_line_items/product_id/increment/1 ==> /basket/order_line_items/product_id/increment/nbProducts
  const hrefPath = $(e.target).data("path").replace('increment/1', `increment/${nbProducts}`);
  const token = $(e.target).data("token");
 
  $.ajax({
    data: {
      authenticity_token: token,
    },
    url: hrefPath,
    type: "POST",
    success: (answer) => {
      $("#basket").html(answer);
      updateNavbarInfos();
      sendAjaxRequestModal(e, nbProducts)
    },
    error: () => {
      $(e.target).LoadingOverlay("hide");
    }
  })
};

function sendAjaxRequestModal(e, nbProducts) {
  e.preventDefault();

  // route replacement : the view _basket_modal_popup.html.erb has another route
  // /basket/order_line_items/product_id/increment/1 ==> /basket/order_line_items/product_id/basket_modal/nbProducts
  const hrefPath = $(e.target).data("path").replace('increment/1', `basket_modal/${nbProducts}`);
  const token = $(e.target).data("token");

  $.ajax({
    data: {
      authenticity_token: token,
    },
    url: hrefPath,
    type: "POST",
    success: (answer) => {
      $("#popupcontent").html(answer);
      $("#overlay").addClass('show');
      $("#popup").addClass('show');
      $(e.target).LoadingOverlay("hide");
    },
    error: () => {
      location.reload();
    }
  })
};

// this function gets the counter (nb products to add to basket)
function getNbProducts(childElement) {
  const parentElement = $(childElement).parents()[2];
  const str = $(parentElement).find(".cart-counter")[0].innerText;
  return parseInt(str);
};
