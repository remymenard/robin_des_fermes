import { openBasket } from './base';
import { addProductHTML } from './utils/productHTML'

require("jquery-form");

$(() => {
  // the button is disabled by default so the user can't use the form before JS loads
  $(".add-to-basket").removeAttr("disabled");

  $('#add-product-form').on('submit', function (e) {
    e.preventDefault();
    $(this).ajaxSubmit({
      success: (answer) => {
        addProductHTML(answer);
        openBasket();
        $(".add-to-basket").removeAttr("disabled");
      }
    });
  });
});
