class window.PhoneValidation extends BaseValidation
  constructor: ->
    super('input#person_contact_attributes_phone')

  run: ->
    switch
      when @field.val() == '' then @setStatus('error', 'Nao pode ficar em branco')
      when not_number(@field) then @setStatus('error', 'Nao e numero')
      when @field.val().length < 8 || @field.val().length > 9  then @setStatus('error', 'Nao e valido')
      else
        @setStatus('valid')