class window.StateValidation extends BaseValidation
  constructor: ->
    super('input.state')

  run: ->
    if is_blank(@field)
      @setStatus('error', 'Nao pode ficar em branco')
    else
      @setStatus('valid')