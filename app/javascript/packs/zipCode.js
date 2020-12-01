import Swal from 'sweetalert2'

document.addEventListener('turbolinks:load', () => {
  $('.zip_code').each(function () {
    $(this).on("click", async () => {
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
      //add a "connect" button if the user in not connected
      if (!zipCodeInfos.data("signedin?")) {
        const loginPath = zipCodeInfos.data("login_path")
        baseModal.footer = `<a href="${loginPath}"> ${I18n.t('zip_code.login')} </a>`
      }

      const {
        value: zip_code
      } = await Swal.fire(baseModal)
      if (/^[1-9]\d{3}$/.test(zip_code)) {
        const setZipCodePath = zipCodeInfos.data("set_zip_code_path")
        $.ajax({
          data: {
            authenticity_token: zipCodeInfos.data("token"),
            zip_code: zip_code
          },
          url: setZipCodePath,
          type: "PATCH"
        })

        $('.zip_code_number').each((_index, element) => {
          $(element).text(zip_code)
        })
        $('#zip_code_input').val(zip_code)
      }
    })
  })
});
