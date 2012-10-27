class window.CellphoneValidation extends BaseValidation
  constructor: ->
    super('input#person_contact_attributes_cellphone')

  run: ->
    if is_blank(@field)
      switch
        when is_blank(@field) then @setStatus('error', 'Nao pode ficar em branco')
        when not_number(@field) then @setStatus('error', 'Nao e numero')
        when @field.val().length < 8 || @field.val().length > 9  then @setStatus('error', 'Nao e valido')
        else
          @setStatus('valid')
    else
      @setStatus('valid')