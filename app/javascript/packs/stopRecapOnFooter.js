export function stopRecapOnFooter() {
  $(window).scroll(() => {
    if($(window).height() < 992) return;
    const footerToTop = $('.footer').position().top;
    const scrollTop = $(document).scrollTop() + $(window).height();
    const difference = scrollTop - footerToTop;
    const bottomValue = scrollTop > footerToTop ? difference : 0;
    $('.position-relative').css('bottom', bottomValue/2);
});
  }
