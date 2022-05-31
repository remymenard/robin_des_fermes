function imageColorDelivery() {

  const elementDelivery = document.querySelector(".image-tabs-delivery");
  const activeDelivery  = document.querySelector(".image-active-delivery");
  const elementWithdrawal = document.querySelector(".image-tabs-withdrawal");
  const activeWithdrawal  = document.querySelector(".image-active-withdrawal");
  const deliveryId = document.querySelector("#delivery");
  const withdrawalId = document.querySelector("#withdrawal");

  elementDelivery.style.display = "none";
  activeWithdrawal.style.display = "none";

  deliveryId.addEventListener("click", (event) => {
    elementDelivery .style.display = "none";
    activeDelivery .style.display = "";
    elementWithdrawal.style.display = "";
    activeWithdrawal.style.display = "none";
  })

  withdrawalId.addEventListener("click", (event) => {
    elementWithdrawal.style.display = "none";
    activeWithdrawal.style.display = "";
    elementDelivery .style.display = "";
    activeDelivery .style.display = "none";
  })
}


export { imageColorDelivery };
