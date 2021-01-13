import {sendAjaxRequest} from '../utils/ajaxRequest'

export function initQuantityButtons() {
  $('#basket').on('click', 'a.increment-button, a.decrement-button', (e) => {
    sendAjaxRequest(e, "POST")});
};
