window.enabledSubmit = (button) ->
  console.log button
  $(button).attr('disabled', false)
  $(button).addClass('submit')
  $(button).attr 'value', $(button).attr('value').replace ' ...', ''

window.disabledSubmit = (button) ->
  console.log button
  $(button).attr('disabled', true)
  $(button).addClass('disabled_submit')
  $(button).attr 'value', " #{ $(button).attr('value') } ..."