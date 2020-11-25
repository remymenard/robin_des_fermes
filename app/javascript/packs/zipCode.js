import Swal from 'sweetalert2'

$('#zip_code').on("click", async () => {
  console.log('click')
  console.log(I18n.t('hello'))
  const { value: email } = await Swal.fire({
    title: 'Code postal',
    input: 'number',
    inputLabel: 'Nous ulisons votre code postal afin de vous proposer les producteurs proches de vous',
    inputPlaceholder: '00000',
    confirmButtonColor: '#007C50',
  })

  if (email) {
    Swal.fire(`Entered email: ${email}`)
  }
})

