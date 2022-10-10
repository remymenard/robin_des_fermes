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

// this function gets the counter (nb products to add to basket)
function getNbProducts(childElement) {
  const parentElement = $(childElement).parents()[2];
  const str = $(parentElement).find(".cart-counter")[0].innerText;
  return parseInt(str);
};


function sendAjaxRequest(e, nbProducts) {
  e.preventDefault();
  $(e.target).LoadingOverlay("show", { imageColor: "#339E72" });

  // route replacement with nb products to add to basket
  const default_suffix = 'increment/1';
  const new_suffix = `increment/${nbProducts}`;
  const hrefPath = $(e.target).data("path").replace(default_suffix, new_suffix);
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
      $("#basket").html(answer);
      updateNavbarInfos();
      sendAjaxRequestModal(e, nbProducts)
      $(e.target).LoadingOverlay("hide");
    },
    error: () => {
      $(e.target).LoadingOverlay("hide");
    }
  })
};

// basket modal, route replacement :
// /basket/order_line_items/product_id/increment/1 replaced by
// /basket/order_line_items/product_id/basket_modal/nbProducts
function sendAjaxRequestModal(e, nbProducts) {
  e.preventDefault();

  // get correct route (see above)
  const default_suffix = 'increment/1';
  const new_suffix = `basket_modal/${nbProducts}`;
  const hrefPath = $(e.target).data("path").replace(default_suffix, new_suffix);
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
    },
    error: () => {
      console.log("error");
    }
  })
};