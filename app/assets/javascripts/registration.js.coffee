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

  $("[data-validate]").keyup ->
    $this = $(this)
    $.get($this.data("validate"),
      name: $this.val()
    ).success(->
      $this.removeClass "field_with_errors"
      $('.error_message').remove()
      return
    ).error ->
      $this.addClass "field_with_errors"
      message = $this.data('err')
      console.log $('.error_message').length
      if $('.error_message').length == 0
        $this.parent().append(" <div class='error_message ui floating red pointing up label'> #{message} </div>")

      return

    return

  return
