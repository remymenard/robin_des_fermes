import Swal from 'sweetalert2'


$('#zip_code').on("click", async () => {
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

  if(!$('#zip_code').data("signedin?")) {
    const loginPath = $('#zip_code').data("login_path")
    baseModal.footer = `<a href="${loginPath}"> ${I18n.t('zip_code.login')} </a>`
  }
  const { value: zip_code } = await Swal.fire(baseModal)

  const setZipCodePath = $('#zip_code').data("set_zip_code_path")
  $.ajax({
    data: { authenticity_token: $('#zip_code').data("token"), zip_code:  zip_code},
    url: setZipCodePath,
    type: "PATCH"
  })

  $('#zip_code_number').text(zip_code)
})

