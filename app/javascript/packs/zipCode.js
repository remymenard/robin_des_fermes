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

  const zipCodeButtons = $('.zip_code');
  const pageInfos = $('#pageInfos')

  const signedIn = zipCodeButtons.data("signedin?")
  const loginPageHref = zipCodeButtons.data("login_path")
  const ajaxRequestHref = zipCodeButtons.data("set_zip_code_path")
  const authenticityToken = zipCodeButtons.data("token")
  const isZipCodeDefined = pageInfos.data('zipCodeDefined')
  const shouldSubmitForm = pageInfos.data('submitForm')
  // end of variables

  // methods
  const addConnectButtonOnAlert = () => {
    if (!signedIn) {
      baseModal.footer = `<a href="${loginPageHref}"> ${I18n.t('zip_code.login')} </a>`
    }
  }

  const showAlert = ({canClickOutside = true}={}) => {
    baseModal.allowOutsideClick = canClickOutside;
    Swal.fire(baseModal).then(zipCode => launchAjaxRequest(zipCode.value));
  }

  const applyClickableEventToButtons = () => {
    zipCodeButtons.each(function () {
      $(this).on("click", showAlert)
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
        type: "PATCH",
        success: (data) => submitForm(data)
      })

      $('.zip_code_number').each((_index, element) => {
        $(element).text(zipCode)
      })
      $('#zip_code_input').val(zipCode)
    }
  }

  const submitForm = (zipCode) => {
    if (shouldSubmitForm) {
      $('#zip').val(zipCode);
      $('#farm-search-form').trigger("submit");
    }
  }

  const autoOpenAlert = () => {
    // must be strictly false not undefined or true
    if (isZipCodeDefined === false) {
      showAlert({canClickOutside: false})
    }
  }
  //end of logic

  // startup logic
  addConnectButtonOnAlert();
  applyClickableEventToButtons();
  autoOpenAlert();
  // end of startup logic

});
