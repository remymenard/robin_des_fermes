require("gasparesganga-jquery-loading-overlay");

function initSubcategories() {
  $('.subcategory-name').on('click', (event) => {
    event.preventDefault();
    if ($(event.target).hasClass('subcategory-name--active')) return;
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

  $('.subcategories-header').on('change', 'input[type=checkbox]', function () {
    sendAjaxRequest();
  });

  $('.order-dropdown').on('change', sendAjaxRequest)
}

function sendAjaxRequest() {
  $('html, body').animate({
    scrollTop: parseInt($(".products-listing").offset().top) - 200
  }, 1000);
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

var stickyOffset;

function calculateOffset() {
  console.log('resize')
  stickyOffset = $('.subcategories-header').offset().top - 50;
}

window.addEventListener("load", function (event) {
  calculateOffset();
  loadSubcategoriesHeader();
  window.addEventListener('resize', calculateOffset);
});

function loadSubcategoriesHeader() {
  $(window).scroll(function () {
    var sticky = $('.subcategories-header'),
      stickyparent = $('.subcategories-header-parent'),
      productList = $('.all-card-product'),
      scroll = $(window).scrollTop();

    if (scroll >= stickyOffset) {
      sticky.addClass('subcategories-header--sticky');
      productList.addClass('all-card-product--sticky')
    } else {
      sticky.removeClass('subcategories-header--sticky');
      productList.removeClass('all-card-product--sticky')
    }
  });
}
