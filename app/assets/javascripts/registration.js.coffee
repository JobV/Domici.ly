$ ->
  $('.submit-registration').click ->
    if ! $('#accept-me').prop('checked')
      alert 'Om te registreren moet je akkoord gaan met de gebruikersverklaring.'
      return false