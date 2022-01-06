require('jquery-form')
require("gasparesganga-jquery-loading-overlay");

function initSubcategories() {
  $('#subcategories-form').ajaxForm(function () {
    alert("Thank you for your comment!");
  });

  $('.subcategory-name').on('click', (event) => {
    event.preventDefault();
    $(".all-card-product").LoadingOverlay("show", {
      imageColor: "#339E72"
    });
    $.ajax({
      url: $('#subcategories-form').attr('action'),
      type: 'PATCH',
      data: $('#subcategories-form').serialize(),
      success: function (answer) {
        $(".all-card-product").html(answer)
        $(".all-card-product").LoadingOverlay("hide");
        console.log(answer);
      },
      error: () => {
        console.log('error')
      }
    });
    return false;
  });

  $('.order-dropdown').on('change', () => {
    $.ajax({
      url: $('#subcategories-form').attr('action'),
      type: 'PATCH',
      data: $('#subcategories-form').serialize(),
      success: function (answer) {
        console.log(answer);
        $(".all-card-product").LoadingOverlay("hide");
        $(".all-card-product").html(answer)
      },
      error: () => {
        console.log('error')
      }
    });
  })
}

document.addEventListener('DOMContentLoaded', initSubcategories)
