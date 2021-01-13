import { sendAjaxRequest } from "../utils/ajaxRequest"
import { openBasket } from "../utils/basketOpener";

$(() => {
  $(".add-to-basket").on("click", (e) => {
    openBasket();
    sendAjaxRequest(e, "POST");
  })
});
