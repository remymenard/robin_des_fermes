// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

import { initMapbox } from '../plugins/init_mapbox';;
import { initAutocomplete } from '../plugins/init_autocomplete';
import { initAxeptio } from '../plugins/init_axeptio';
import { initBasket } from './basket/utils/initBasket'
import { loadResponsiveNavbar } from './navbar'
import { initSelect2 } from '../plugins/init_select2'
import { Carousel } from '../plugins/owl_carousel'
import { stopRecapOnFooter } from '../packs/stopRecapOnFooter'
import { initDeliverySelect } from '../packs/delivery'

document.addEventListener('turbolinks:load', () => {
  initAutocomplete();
  initMapbox();
  initAxeptio();
  initBasket();
  loadResponsiveNavbar();
  initSelect2();
  Carousel();
  stopRecapOnFooter();
  initDeliverySelect();
});

$(document).on('turbolinks:before-cache', function() {
  $(".owl-carousel").owlCarousel('destroy');
});

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
