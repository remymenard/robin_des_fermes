import {
  startLoadingAnimation,
  stopLoadingAnimation
} from "./loadingAnimation";
import {
  updateNavbarInfos
} from "./updateNavbarInfos";

export function sendAjaxRequest(e, requestType, reloadPage = false) {
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
      if (reloadPage) {
        location.reload();
      } else {
        $("#basket").html(answer)
        stopLoadingAnimation();
        updateNavbarInfos();
      }
    }
  })
};
