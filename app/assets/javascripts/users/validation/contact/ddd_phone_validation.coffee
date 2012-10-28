class window.DddPhoneValidation extends BaseValidation
  constructor: ->
    super('input#person_contact_attributes_ddd_phone')

  run: ->
    switch
      when @field.val() == '' then @setStatus('error', 'Nao pode ficar em branco')
      when not_number(@field) then @setStatus('error', 'Nao e numero')
      when @field.val().length > 4 || @field.val().length < 4  then @setStatus('error', 'Nao e valido')
      else
        @setStatus('valid')