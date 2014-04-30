var ready;
ready = function() {
  
  $('.ui.form')
    .form({
      event_title: {
        identifier: 'event_title',
        rules: [{
          type: 'empty',
          prompt: 'Voer een titel in'
        }]
      },
      event_hour: {
        identifier: 'event_hour',
        rules: [{
          type: 'empty',
          prompt: 'Voer een tijdstip in'
        }]
      },
      event_min: {
        identifier: 'event_min',
        rules: [{
          type: 'empty',
          prompt: 'Voer een tijdstip in'
        }]
      }
    }, 
    {
      inline : true,
      on     : 'blur'
    })
  ;

};

$(document).ready(ready);
$(document).on('page:load', ready);

