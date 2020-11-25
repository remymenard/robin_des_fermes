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
      return true;
    }
  }

  if(!$('#zip_code').data("signedin?")) {
    baseModal.footer = `<a href="/users/sign_in">${I18n.t('zip_code.login')}</a>`
  }
  const { value: zip_code } = await Swal.fire(baseModal)

  $.ajax({
    data: { authenticity_token: $('#zip_code').data("token"), zip_code:  zip_code},
    url: "/set_zip_code/",
    type: "POST"
  })
})

