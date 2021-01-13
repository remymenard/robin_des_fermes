import { sendAjaxRequest } from "../utils/ajaxRequest"
import { openBasket } from "../utils/basketOpener";

export function initAddToBasketButton() {
  $(".add-to-basket").on("click", async (e) => {
    await openBasket()
    sendAjaxRequest(e, "POST")
  })
}
