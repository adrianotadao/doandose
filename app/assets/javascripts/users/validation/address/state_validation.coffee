class window.StateValidation extends BaseValidation
  constructor: ->
    super('input.state')

  run: ->
    if @field.val() == ''
      @setStatus('error', 'Nao pode ficar em branco')
    else
      @setStatus('valid')