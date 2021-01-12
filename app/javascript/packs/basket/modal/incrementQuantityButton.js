$(() => {
  $('#basket').on('click', '.increment-button', (e) => {
    e.preventDefault();
    const hrefPath = $(e.target).data("path");
    const productId = $(e.target).data("productId");
    const token = $(e.target).data("token");
    $.ajax({
      data: {
        authenticity_token: token,
        product_id: productId
      },
      url: hrefPath,
      type: "POST",
      success: (answer) => {
        $("#products").html(answer)
      }
    })
  });
});
