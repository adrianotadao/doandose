class window.UsernameValidation extends BaseValidation
  constructor: ->
    super('#person_name')

  run: ->
    switch
      when @field.val() == '' then @setStatus('error', 'Digite seu nome')
      when @field.val().match(/\s/gi) then @setStatus('error', 'Contém espaços')
      when @field.val().length > 30 then @setStatus('error', "Excedeu #{@field.val().length - 30} caracteres")
      when @field.val().length < 4 then @setStatus('error', 'Mínimo 4 caracteres')
      else
        @setStatus('valid')