class window.HeightValidation extends BaseValidation
  constructor: ->
    super('#person_height')

  run: ->
    switch
      when is_blank(@field) then  @setStatus('error', 'Nao pode ficar em branco')
      when @field.val().length > 3 || @field.val().length < 2 then @setStatus('error', 'Altura invalida')
      when not_number(@field) then @setStatus('error', 'Nao e um numero')
      else
        @setStatus('valid')