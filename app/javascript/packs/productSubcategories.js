require("gasparesganga-jquery-loading-overlay");

function initSubcategories() {
  $('.subcategory-name').on('click', (event) => {
    event.preventDefault();
    if ($(event.target).hasClass('subcategory-name--default')) {
      $('#subcategory_id').val(null)
    } else {
      $('#subcategory_id').val(event.target.dataset.subcategoryId)
    }
    $('.subcategory-name').each((_index, element) => {
      $(element).removeClass('subcategory-name--active')
    })
    $(event.target).addClass('subcategory-name--active')
    sendAjaxRequest();
  });

  $('.order-dropdown').on('change', sendAjaxRequest)
}

function sendAjaxRequest() {
  $(".all-card-product").LoadingOverlay("show", {
    imageColor: "#339E72"
  });
  $.ajax({
    url: $('#subcategories-form').attr('action'),
    type: 'PATCH',
    data: $('#subcategories-form').serialize(),
    success: function (answer) {
      $(".all-card-product").LoadingOverlay("hide");
      $(".all-card-product").html(answer)
    },
    error: () => {
      $(".all-card-product").LoadingOverlay("hide");
    }
  });
}

document.addEventListener('DOMContentLoaded', initSubcategories)
