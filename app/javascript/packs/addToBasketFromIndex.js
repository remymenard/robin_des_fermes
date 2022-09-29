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

      //nb products to add to basket
      const nbProducts = getNbProducts(button);

      // basket, route replacement :
      // /basket/order_line_items/product_id/increment/1 replaced by
      // /basket/order_line_items/product_id/increment/nbProducts
      sendAjaxRequest(e, nbProducts, "increment", false);

      // basket modal, route replacement :
      // /basket/order_line_items/product_id/increment/1 replaced by
      // /basket/order_line_items/product_id/basket_modal/nbProducts
      sendAjaxRequest(e, nbProducts, "basket_modal", true);

    });
  });
});

// this function gets the counter (nb products to add to basket)
function getNbProducts(childElement) {
  const parentElement = $(childElement).parents()[2];
  const str = $(parentElement).find(".cart-counter")[0].innerText;
  return parseInt(str);
};


function sendAjaxRequest(e, nbProducts, replaceBy, modal) {
  e.preventDefault();
  
  // animate button
  $(e.target).LoadingOverlay("show", { imageColor: "#339E72" });

  // get correct route (see above)
  const default_suffix = 'increment/1';
  const new_suffix = `${replaceBy}/${nbProducts}`;
  const hrefPath = $(e.target).data("path").replace(default_suffix, new_suffix);
  const token = $(e.target).data("token");

  // fire ajax request  
  $.ajax({
    data: {
      authenticity_token: token,
    },
    url: hrefPath,
    type: "POST",
    success: (answer) => {
      if (modal == true) {
        $("#popupcontent").html(answer);
        $("#overlay").addClass('show');
        $("#popup").addClass('show');
      } else {
        $("#basket").html(answer);
        updateNavbarInfos();
      }
      $(e.target).LoadingOverlay("hide");
    },
    error: () => {
      $(e.target).LoadingOverlay("hide");
    }
  })
};

