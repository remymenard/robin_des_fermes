import Swal from 'sweetalert2'

document.addEventListener('turbolinks:load', async () => {
  // variables
  let baseModal = {
    title: I18n.t('zip_code.title'),
    inputLabel: I18n.t('zip_code.description'),
    input: 'number',
    inputPlaceholder: '0000',
    confirmButtonColor: '#007C50',
    preConfirm: (zip_code) => {
      if (!/^[1-9]\d{3}$/.test(zip_code)) {
        Swal.showValidationMessage(I18n.t('zip_code.error'))
      }
      return zip_code;
    }
  }
  const zipCodeInfos = $('.zip_code');
  const signedIn = zipCodeInfos.data("signedin?")
  const loginPageHref = zipCodeInfos.data("login_path")
  const ajaxRequestHref = zipCodeInfos.data("set_zip_code_path")
  const authenticityToken = zipCodeInfos.data("token")


  // methods
  const findAllZipCodeButtonsOnPage = () => {
    return $('.zip_code')
  }

  const addConnectButtonOnAlert = () => {
    if (!signedIn) {
      baseModal.footer = `<a href="${loginPageHref}"> ${I18n.t('zip_code.login')} </a>`
    }
  }

  const applyClickableEventToButtons = (buttons) => {
    buttons.each(function () {
      $(this).on("click", () => {
        Swal.fire(baseModal).then((zipCode) => {
          launchAjaxRequest(zipCode.value);
        })
      })
    })
  }

  const launchAjaxRequest = (zipCode) => {
    if (/^[1-9]\d{3}$/.test(zipCode)) {
      $.ajax({
        data: {
          authenticity_token: authenticityToken,
          zip_code: zipCode
        },
        url: ajaxRequestHref,
        type: "PATCH"
      })

      $('.zip_code_number').each((_index, element) => {
        $(element).text(zipCode)
      })
      $('#zip_code_input').val(zipCode)
    }
  }
  // startup logic
  let buttons = findAllZipCodeButtonsOnPage();
  addConnectButtonOnAlert();
  applyClickableEventToButtons(buttons);
});
