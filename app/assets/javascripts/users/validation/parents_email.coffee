class window.ParentsEmail extends BaseValidation
  constructor: ->
    parent_email = '#users_user_parents_email'
    super(parent_email)

    $(parent_email).change (e) ->
      value = $(e.currentTarget).val().replace(/\s/g, '')
      $(e.currentTarget).val( value.toLowerCase() )

  run: ->
    yearBirthdate = $('#users_user_birthdate').val().split('/')[2]
    currentDate = new Date()
    expReg = /^([a-zA-Z0-9\.\-\+]+[a-zA-Z0-9._-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/

    @lastValue = ' '
    if ( currentDate.getFullYear() - yearBirthdate ) <= 12
      switch
        when @field.val() == '' then @setStatus('error', 'Preencha o e-mail')
        when @field.val().length > 100 then @setStatus('error', 'Excedeu o limite')
        when !expReg.test(@field.val()) then @setStatus('error', 'E-mail inválido')
        else @setStatus('valid')
    else
      @setStatus('valid')