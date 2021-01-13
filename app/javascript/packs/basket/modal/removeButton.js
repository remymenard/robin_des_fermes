import { sendAjaxRequest } from '../utils/ajaxRequest'

export function initRemoveButton() {
  $(".remove-item-button").on("click", (e) => sendAjaxRequest(e, "DELETE"))
}
