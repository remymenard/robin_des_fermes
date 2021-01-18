import { startLoadingAnimation, stopLoadingAnimation } from "./loadingAnimation";
import { updateItemsCount } from "./updateItemsCount";

export function sendAjaxRequest(e, requestType) {
  e.preventDefault();
  const hrefPath = $(e.target).data("path");
  const token = $(e.target).data("token");
  startLoadingAnimation();
  $.ajax({
    data: {
      authenticity_token: token,
    },
    url: hrefPath,
    type: requestType,
    success: (answer) => {
      $("#basket").html(answer)
      stopLoadingAnimation();
      updateItemsCount();
    }
  })
};
