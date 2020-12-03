document.addEventListener('turbolinks:load', () => {
  const payButton     = document.getElementById("paymentButton");
  const transactionId = payButton.dataset.transactionId

  payButton.addEventListener("click", function() {
    Datatrans.startPayment({
      transactionId:  transactionId
    });
  });
});
