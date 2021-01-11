require("jquery-form");

export function getAddProductAnswer() {
  //called when the "+" form is sent
  $("#add-product-form").ajaxSubmit({
    success: function (response) {
        console.log("The server says: " + response);
    }
  });

}
