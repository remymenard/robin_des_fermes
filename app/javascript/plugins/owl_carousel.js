import owlCarousel from "owl.carousel2";
import "owl.carousel2/dist/assets/owl.carousel.css";

const Carousel = () => {
  $(document).ready(function(){
    $('.owl-carousel').owlCarousel({
      stagePadding: 190,
      loop: true,
      margin:10,
      items: 1,
      autoplay: true,
      autoplayTimeout:7000,
      autoplayHoverPause:false
    })
  })
};

export { Carousel };
