import owlCarousel from "owl.carousel2";

const Carousel = () => {
  $(document).ready(function(){
    if (document.querySelector('.home-category')) {
      $('.owl-carousel').owlCarousel({
        stagePadding: 0,
        loop: true,
        margin:10,
        autoplay: true,
        autoplayTimeout:7000,
        autoplayHoverPause:false,
        responsive:{
          0:{
            items:1.15,
          },
          600:{
            items:1.15,
          },
          1000:{
            items:1.15,
          }
        }
      })
    }
    else if (document.querySelector('.card-farm-carousel')) {
      $('.owl-carousel').owlCarousel({
      loop:true,
      margin: 10,
      nav: true,
      autoWidth: true
      })
    }
    else {
      $('.owl-carousel').owlCarousel({
        responsive : {
          0 : {
              items:1,
              stagePadding: 0,
          },
          900 : {
              stagePadding: 190,
              loop: true,
              margin:10,
              items: 1,
              autoplay: true,
              autoplayTimeout:7000,
              autoplayHoverPause:false,
          },
          1600 : {
              stagePadding: 250,
              loop: true,
              margin:10,
              items: 1,
              autoplay: true,
              autoplayTimeout:7000,
              autoplayHoverPause:false,
          },
        }
      })
    }
  })
};

export { Carousel };
