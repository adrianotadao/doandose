class window.DddCellphoneValidation extends BaseValidation
  constructor: ->
    super('input#person_contact_attributes_ddd_cellphone')

  run: ->
    if is_blank('input#person_contact_attributes_ddd_phone')
      switch
        when is_blank(@field) then @setStatus('error', 'Nao pode ficar em branco')
        when not_number(@field) then @setStatus('error', 'Nao e numero')
        when @field.val().length > 4 || @field.val().length < 4  then @setStatus('error', 'Nao e valido')
        else
          @setStatus('valid')
    else
      @setStatus('valid')