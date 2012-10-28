class window.ZipCodeValidation extends BaseValidation
  constructor: ->
    super('input.zip_code')

  run: ->
    if @field.val() == ''
      @setStatus('error', 'Nao pode ficar em branco')
    else
      @setStatus('valid')