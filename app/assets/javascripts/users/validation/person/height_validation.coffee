class window.HeightValidation extends BaseValidation
  constructor: ->
    super('#person_height')

  run: ->
    if @field.val() == ''
      @setStatus('error', 'Nao pode ficar em branco')
    else
      @setStatus('valid')