import {updateNavbarInfos} from '../packs/basket/utils/updateNavbarInfos';

document.addEventListener('DOMContentLoaded', () => {
  
  // list of all buttons
  const buttons = document.querySelectorAll('.add-product-to-basket');
  const basketModal = document.getElementById('basket-modal-container');
  //const closeButton = document.getElementById('');

  // add eventListener on all cart buttons
  buttons.forEach((button) => {
    button.addEventListener("click", (e) => {

      //nb products to add to basket
      const nbProducts = getNbProducts(button);
      
      // we update basket
      sendAjaxRequest(e, "POST", nbProducts);

      // we update basket-modal + open basket-modal
      sendAjaxRequestModal(e, "POST", basketModal);
    });
  });

/*   closeButton.addEventListener("click", () => {
    closeModal(event, basketModal);
  }); */

  // When the user clicks anywhere outside of the modal, close it: other method to write an eventlistener
  window.onclick = function(event) {
    closeModal(event, basketModal);
  };

});

// this function gets the counter (nb products to add to basket)
function getNbProducts(childElement) {
  const parentElement = $(childElement).parents()[2];
  const str = $(parentElement).find(".cart-counter")[0].innerText;
  return parseInt(str);
};

function closeModal(event, modalName) {
  if (event.target == modalName) {
    modalName.style.display = "none";
  }
};

function sendAjaxRequest(e, requestType, nbProducts, reloadPage = false) {
  e.preventDefault();
  const default_suffix = "increment/1";
  const new_suffix = "increment/" + nbProducts;
  let hrefPath = $(e.target).data("path").replace(default_suffix, new_suffix);
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

function sendAjaxRequestModal(e, requestType, modal, reloadPage = false) {
  e.preventDefault();
  console.log($(e.target).data("path"));
  let hrefPath = $(e.target).data("path").replace("increment/1", "basket_modal")
  console.log(hrefPath);
  const token = $(e.target).data("token");

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
        $("#basket-modal-container").html(answer);
        $(modal).css('display', 'flex');
      }
    }
  })
};
