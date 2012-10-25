class window.NeighborhoodValidation extends BaseValidation
  constructor: ->
    super('input.neighborhood')

  run: ->
    if is_blank(@field)
      @setStatus('error', 'Nao pode ficar em branco')
    else
      @setStatus('valid')