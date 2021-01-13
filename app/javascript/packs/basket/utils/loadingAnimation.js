require("gasparesganga-jquery-loading-overlay")

export function startLoadingAnimation() {
  $("#products").LoadingOverlay("show", {
    imageColor  : "#339E72"
  });
}

export function stopLoadingAnimation() {
  $("#products").LoadingOverlay("hide");
}
