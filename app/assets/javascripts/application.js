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
//= require list
//= require nprogress
//= require nprogress-turbolinks
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

  
  $('.ui.form')
    .form({
      alert_title: {
        identifier: 'alert_title',
        rules: [{
          type: 'empty',
          prompt: 'Voer een titel in'
        }]
      },
      event_title: {
        identifier: 'event_title',
        rules: [{
          type: 'empty',
          prompt: 'Voer een titel in'
        }]
      },
      event_date: {
        identifier: 'datepicker',
        rules: [{
          type: 'empty',
          prompt: 'Kies een datum'
        }]
      },
      event_hour: {
        identifier: 'event_hour',
        rules: [{
          type: 'empty',
          prompt: 'Voer een tijdstip in'
        },
        {
          type: 'maxLength[2]',
          prompt: 'Incorrect tijdstip'
        }]
      },
      event_min: {
        identifier: 'event_min',
        rules: [{
          type: 'empty',
          prompt: 'Voer een tijdstip in'
        },
        {
          type: 'maxLength[2]',
          prompt: 'Incorrect tijdstip'
        }]
      },
      user_email: {
        identifier: 'user_email',
        rules: [{
          type: 'email',
          prompt: 'Voer een emailadres in'
        }]
      }
    }, 
    {
      inline : true,
      on     : 'blur'
    })
  ;

  // Alerts tabs
  $('#tabs .tab').hide();
  $('#tabs .tab:first').show();
  $('.ui.tabular.menu a.item:first').addClass('active');

  $('.ui.tabular.menu a.item').click(function(){
    $('.ui.tabular.menu a').removeClass('active');
    $(this).addClass('active');

    var currentTab = $(this).attr('href');
    $('#tabs .tab').hide();
    $(currentTab).show();
    return false;
  });

  // $('.presence.sidebar')
  //   .sidebar('toggle')
  // ;

  $('.toggle-sidebar').click(function() {
    $('.sidebar')
      .sidebar({overlay: true})
      .sidebar('toggle')
    ;
  });

  // Hide sidebar on click outside of sidebar
  $(document).mouseup(function (e) {
    var container = $('.sidebar');

    if (!container.is(e.target)
        && container.has(e.target).length === 0) {
        container.sidebar('hide');
        }
  });

  $('.disable-sidebar').click(function(argument) {
    $('.sidebar')
      .sidebar('toggle')
      ;
  });
  
};

$(document).ready(ready);
$(document).on('page:load', ready);

