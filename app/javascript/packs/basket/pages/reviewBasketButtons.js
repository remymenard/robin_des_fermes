import { sendAjaxRequest } from "../utils/ajaxRequest"

export function reviewBasketButtons() {
  $('.review').on('click', '.increment-button, .decrement-button', (e) => {
    if($(e.target).hasClass('disabled-button')) return;
    sendAjaxRequest(e, "POST", true)
  });

  $(".review").on("click", '.remove-item-button', (e) => {
    sendAjaxRequest(e, "DELETE", true)
  })
}
