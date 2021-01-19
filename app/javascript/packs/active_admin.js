// Load Active Admin's styles into Webpacker,
// see `active_admin.scss` for customization.
//= require jquery
//= require jquery_ujs
import "../stylesheets/active_admin";

import "@activeadmin/activeadmin";
import "activeadmin_addons"

import "@fortawesome/fontawesome-free/css/all.css";
import 'arctic_admin'

$(document).on('DOMContentLoaded', () => {
  //script for the search already existing user input
  $('#farm_user_id').on('select2:select', function (e) {
    $('.owner-form').css('display', 'none');
  });

  $('#farm_user_id').on('select2:unselect', function (e) {
    $('.owner-form').css('display', 'block');
  });

  $('#farm_submit_action').on('click', () => {
    if ($('.owner-form').css('display') == 'none') {
      $('#farm_user_attributes_id').remove();
      $('.owner-form').remove();
    }
  })
});
