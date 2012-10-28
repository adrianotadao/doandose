class window.StreetValidation extends BaseValidation
  constructor: ->
    super('input.street')

  run: ->
    if @field.val() == ''
      @setStatus('error', 'Nao pode ser branco')
    else
      @setStatus('valid')