document.addEventListener('turbolinks:load', () => {
  $('.mobile-big-question-mark').on('click', () => {
    $('.map-infos').css('display', 'block')
  })

  $('.close-infos').on('click', () => {
    $('.map-infos').css('display', 'none')
  })
})
