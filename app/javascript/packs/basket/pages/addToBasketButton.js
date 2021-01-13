$(() => {
  // the button is disabled by default so the user can't use the form before JS loads
  $(".add-to-basket").removeAttr("disabled");

  $('#add-product-form').on('submit', function () {
    e.preventDefault();
    $(this).ajaxSubmit({
      success: (answer) => {
        $("#products").html(answer)
        $(".add-to-basket").removeAttr("disabled");
      },
      error: () => {
        alert('eror')
      }
    });
  });
});
