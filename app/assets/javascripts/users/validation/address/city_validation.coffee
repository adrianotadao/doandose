class window.CityValidation extends BaseValidation
  constructor: ->
    super('input.city')

  run: ->
    if @field.val() == ''
      @setStatus('error', 'Nao pode ficar em branco')
    else
      @setStatus('valid')