import {sendAjaxRequest} from '../utils/ajaxRequest'

export function initQuantityButtons() {
  $('#basket').on('click', '.increment-button, .decrement-button', (e) => {
    if ($(e.target).hasClass('disabled-button')) return;
    sendAjaxRequest(e, "POST")});
};
