$ ->
  $('.submit-registration').click ->
    if ! $('#accept-me').prop('checked')
      alert 'Om te registreren moet je akkoord gaan met de gebruikersverklaring.'
      return false

  $('#gebruikersverklaring').click ->
    $('.ui.modal')
      .modal('show')

  $('#subdomain_full').text($('#subdomain_name').val() + '.domici.ly')

  $('#subdomain_name').keyup ->
    $('#subdomain_full').text($(this).val() + '.domici.ly')
