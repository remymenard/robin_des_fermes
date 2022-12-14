// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("css3sidebar/dist/jquery.css3sidebar.js")
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
import 'select2'

import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';
import { imageColorDelivery } from '../plugins/image_color_delivery';
import { initAxeptio } from '../plugins/init_axeptio';
import { initBasket } from './basket/utils/initBasket';
import { initSelect2 } from '../plugins/init_select2';
import { initNoty } from '../plugins/init_noty';
import { Carousel } from '../plugins/owl_carousel';
import { stopRecapOnFooter } from '../packs/stopRecapOnFooter';
import { initDeliverySelect } from '../packs/delivery';

document.addEventListener('DOMContentLoaded', () => {
  initAutocomplete();
  initMapbox();
  initAxeptio();
  initBasket();
  initSelect2();
  initNoty();
  Carousel();
  stopRecapOnFooter();
  initDeliverySelect();
  imageColorDelivery();
});

$(document).on('turbolinks:before-cache', function() {
  $(".owl-carousel").owlCarousel('destroy');
});

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
