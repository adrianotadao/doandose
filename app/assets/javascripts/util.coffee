window.enabledSubmit = (button) ->
  $(button).attr('disabled', false)
  $(button).addClass('submit')
  $(button).attr 'value', $(button).attr('value').replace ' ...', ''

window.disabledSubmit = (button) ->
  $(button).attr('disabled', true)
  $(button).addClass('disabled_submit')
  $(button).attr 'value', " #{ $(button).attr('value') } ..."

window.addLoad = (element) ->
  html = "<div id='load'>
                <img alt='Load' class='load' src='/assets/load.gif'> Carregando ...
                </div> "

  $(element).css(
    'opacity', 0.2,
    'position', 'relative',
    'top', 0,
    'left', 0
  )

  $(element).after(html) unless $('#load').exists()

window.removeLoad = (element) ->
  $(element).css('opacity', 1)
  $('#load').remove()

jQuery.fn.exists = ->
  return jQuery(this).length == 1