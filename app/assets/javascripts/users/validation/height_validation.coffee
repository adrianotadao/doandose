class window.HeightValidation extends BaseValidation
  constructor: ->
    super('#person_height')

  run: ->
    if @field.val() == ''
      @setStatus('error', 'Digite sua altura')
    else if @field.val().length > 3
      @setStatus('error', 'Altura invalida')
    else
      @setStatus('valid')