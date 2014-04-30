var ready;
ready = function() {

  // $('.ui.dropdown')
  //   .form(validationRules, {
  //     inline : true,
  //     on     : 'blur'
  //   })
  // ;
  
  $('.ui.form')
    .form({
      event_title: {
        identifier: 'event_title',
        rules: [{
          type: 'empty',
          prompt: 'Voer een titel in'
        }]
      }
    })
  ;
};

$(document).ready(ready);
$(document).on('page:load', ready);

