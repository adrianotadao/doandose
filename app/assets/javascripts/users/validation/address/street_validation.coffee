class window.StreetValidation extends BaseValidation
  constructor: ->
    super('input.street')

  run: ->
    if is_blank(@field)
      @setStatus('error', 'Nao pode ser branco')
    else
      @setStatus('valid')