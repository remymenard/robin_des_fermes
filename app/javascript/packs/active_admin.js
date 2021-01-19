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
  $('#farm_user_id').on('select2:select', function (e) {
    $('.owner-form').remove();
    $('#farm_user_attributes_id').remove();
});
});
