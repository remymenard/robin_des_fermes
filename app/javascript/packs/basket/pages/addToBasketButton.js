import { sendAjaxRequest } from "../utils/ajaxRequest"
import { openBasket } from "../utils/basketOpener";

$(() => {
  $(".add-to-basket").on("click", async (e) => {
    await openBasket()
    sendAjaxRequest(e, "POST")
  })
});
