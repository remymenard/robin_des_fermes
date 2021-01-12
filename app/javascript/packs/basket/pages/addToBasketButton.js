import { openBasket } from '../utils/basketOpener';
import { updateTotalPrice } from '../utils/updateTotalPrice'

require("jquery-form");

$(() => {
  // the button is disabled by default so the user can't use the form before JS loads
  $(".add-to-basket").removeAttr("disabled");

  $('#add-product-form').on('submit', function (e) {
    e.preventDefault();
    $(this).ajaxSubmit({
      success: (answer) => {
        $("#products").html(answer)
        openBasket();
        $(".add-to-basket").removeAttr("disabled");
        updateTotalPrice();
      },
      error: () => {
        alert('eror')
      }
    });
  });
});
