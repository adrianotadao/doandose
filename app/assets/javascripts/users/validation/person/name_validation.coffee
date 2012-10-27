class window.NameValidation extends BaseValidation
  constructor: ->
    super('#person_name')

  run: ->
    switch
      when is_blank(@field) then @setStatus('error', 'Nao pode ficar em branco')
      when @field.val().match(/\s/gi) then @setStatus('error', 'Contém espaços')
      when @field.val().length > 30 then @setStatus('error', "Excedeu #{@field.val().length - 30} caracteres")
      when @field.val().length < 2 then @setStatus('error', 'Mínimo 4 caracteres')
      else
        @setStatus('valid')