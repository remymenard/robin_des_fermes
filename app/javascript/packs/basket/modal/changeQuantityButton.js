import {sendAjaxRequest} from '../utils/ajaxRequest'

export function initQuantityButtons() {
  $('#basket').on('click', '.increment-button, .decrement-button', (e) => sendAjaxRequest(e, "POST"));
};
