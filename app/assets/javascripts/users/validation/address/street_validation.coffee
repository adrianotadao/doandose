class window.StreetValidation extends BaseValidation
  constructor: ->
    surname = 'input.street'
    super(surname)

  run: ->
    if is_blank(@field)
      @setStatus('error', 'Nao pode ser branco')
    else
      @setStatus('valid')