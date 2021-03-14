const Noty = require('noty');

export function initNoty() {
  $(".railsAlert").each((_index, element) => {
    startAlert($(element).data("type"), $(element).data("text"))
  })

  $(".simpleFormAlert").each((_index, element) => {
    const errorType = $(element).hasClass("valid") ? "success" : "error";
    startAlert(errorType, $(element).text())
  })
}

function startAlert(type, text) {
  new Noty({
    type: type,
    text: text,
    theme: 'metroui',
    layout: 'bottomLeft',
    timeout: 3000
  }).show();
}
