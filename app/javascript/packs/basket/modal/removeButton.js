import { sendAjaxRequest } from '../utils/ajaxRequest'

export function initRemoveButton() {
  $("#basket").on("click", '.remove-item-button', (e) => sendAjaxRequest(e, "DELETE"))
}
