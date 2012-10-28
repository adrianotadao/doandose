class window.NeighborhoodValidation extends BaseValidation
  constructor: ->
    super('input.neighborhood')

  run: ->
    if @field.val() == ''
      @setStatus('error', 'Nao pode ficar em branco')
    else
      @setStatus('valid')