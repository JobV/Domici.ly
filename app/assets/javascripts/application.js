// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require semantic-ui
//= require moment
//= require pikaday
//= require chosen-jquery
//= require_tree .

var ready;
ready = function() {

  $('.ui.dropdown')
    .dropdown()
  ;

  $('.ui.radio.checkbox')
    .checkbox()
  ;

  $('.ui.checkbox')
    .checkbox()
  ;

  $('.message .close').on('click', function() {
    $(this).closest('.message').fadeOut();
  });

  $('.ui.accordion')
    .accordion()
  ;

  $('.image')
    .dimmer({
      on: 'hover'
    })
  ;

  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'Geen match =('
  });


  var picker = new Pikaday({
        field: $('#datepicker')[0],
        format: 'YYYY-MM-DD',
        onSelect: function() {
          $('#datepicker').val(picker.toString());
        }
    });

  $('ui.sidebar')
    .sidebar()
  ;

};

$(document).ready(ready);
$(document).on('page:load', ready);

