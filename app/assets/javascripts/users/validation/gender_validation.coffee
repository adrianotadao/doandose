class window.GenderValidation extends BaseValidation
  constructor: ->
    super('#users_user_gender')

  run: ->
    switch
      when @field.val() != ''
        if @field.val() == 'm' || @field.val() == 'f'
          @setStatus('valid')
        else
          @setStatus('error', 'Utilize os seletores')

      else
        @setStatus('error', 'Deve ser preenchido')