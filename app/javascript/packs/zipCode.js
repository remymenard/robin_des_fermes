import Swal from 'sweetalert2'

document.addEventListener('DOMContentLoaded', async () => {
  // variables
  const zipCodeButtons = $('.zip-code-infos')
  const zipCodeText = $('.zip_code_number')
  const searchInput = $('.zip_code_input')
  const pageInfos = $('#pageInfos')
  const zipCodeMessages = $('#zip_code_messages')

  const signedIn = zipCodeButtons.data("signedin?")
  const loginPageHref = zipCodeButtons.data("login_path")
  const ajaxRequestHref = zipCodeButtons.data("set_zip_code_path")
  const authenticityToken = zipCodeButtons.data("token")
  const isZipCodeDefined = pageInfos.data('zipCodeDefined')
  const shouldSubmitForm = pageInfos.data('submitForm')

  const titleMessage = zipCodeMessages.data('title')
  const descriptionMessage = zipCodeMessages.data('description')
  const loginMessage = zipCodeMessages.data('login')
  const errorMessage = zipCodeMessages.data('error')

  let baseModal = {
    title: titleMessage,
    inputLabel: descriptionMessage,
    input: 'number',
    inputPlaceholder: '0000',
    confirmButtonColor: '#007C50',
    preConfirm: (zip_code) => {
      if (!/^[1-9]\d{3}$/.test(zip_code)) {
        Swal.showValidationMessage(errorMessage)
      }
      return zip_code;
    }
  }
  // end of variables

  // methods
  const addConnectButtonOnAlert = () => {
    if (!signedIn) {
      baseModal.footer = `<a href="${loginPageHref}"> ${loginMessage} </a>`
    }
  }

  const showAlert = ({canClickOutside = true}={}) => {
    baseModal.allowOutsideClick = canClickOutside;
    Swal.fire(baseModal).then(zipCode => launchAjaxRequest(zipCode.value));
  }

  const applyClickableEventToButtons = () => {
    $.merge(zipCodeButtons, searchInput).each(function () {
      $(this).on("click", (e) => {
        e.preventDefault();
        showAlert()
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
        type: "PATCH",
        success: (data) => submitForm(data)
      })
    }

    const submitForm = (zipCode) => {
      zipCodeText.each((_index, element) => {
        $(element).text(zipCode)
      })
      searchInput.each((_index, input) => {
        $(input).val(zipCode)
      })
      if (shouldSubmitForm) {
        $('#zip').val(zipCode);
        $('#farm-search-form').trigger("submit");
        $('.search').trigger("submit");
      }
      else {
        location.reload()
      }
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
