$ ->
  $('.submit-registration').click ->
    if ! $('#accept-me').prop('checked')
      alert 'Om te registreren moet je akkoord gaan met de gebruikersverklaring.'
      return false

  $('#gebruikersverklaring').click ->
    $('.ui.modal')
      .modal('show')

  $('#subdomain_full').text($('#hoa_subdomain_name').val() + '.domici.ly')

  $('#hoa_subdomain_name').keyup ->
    $('#subdomain_full').text($(this).val() + '.domici.ly')

  $("[data-validate]").blur ->
    $this = $(this)
    $.get($this.data("validate"),
      name: $this.val()
    ).success(->
      $this.removeClass "field_with_errors"
      return
    ).error ->
      $this.addClass "field_with_errors"
      message = $("[validation-message]").val()
      console.log message
      $this.after(" <div class=''> #{message} </div>")
      return

    return

  return