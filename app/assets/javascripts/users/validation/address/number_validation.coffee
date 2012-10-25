class window.NumberValidation extends BaseValidation
  constructor: ->
    super('input.number')

  run: ->
    switch
      when is_blank(@field) then @setStatus('error', 'Nao pode ficar em branco')
      when not_number(@field) then @setStatus('error', 'Nao e um numero')
      when @field.val().length > 10 then @setStatus('error', 'Excedeu !!!')
      else
        @setStatus('valid')