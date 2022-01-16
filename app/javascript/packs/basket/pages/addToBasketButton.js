import {
  sendAjaxRequest
} from "../utils/ajaxRequest"
import {
  openBasket
} from "../utils/basketOpener";

export function initAddToBasketButton() {
  $("body").on("click", ".add-to-basket", async (e) => {
    await openBasket()
    sendAjaxRequest(e, "POST")
  })
}
