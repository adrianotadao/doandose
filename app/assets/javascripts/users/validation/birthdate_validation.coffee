class window.BirthdateValidation extends BaseValidation
  constructor: () ->
    @birthdate = '#users_user_birthdate'
    super(@birthdate)
    @parentsEmail = $('.parents_email')
    @currentDate = new Date
    @showParentsEmail($(@birthdate).val().split('/')[2])

  run: ->
    unless @validationDate()
      @setStatus('error', 'Data inválida')
    else
      @setStatus('valid')

  validationDate: =>
    expReg = /^(([0-2]\d|[3][0-1])\/([0]\d|[1][0-2])\/[1-2][0-9]\d{2})$/
    arrayDate = @field.val().split('/')
    requiredYear = @currentDate.getFullYear() - 1

    if @field.val().match(expReg) && arrayDate[1] != '00' && arrayDate[0] != '00'
      switch
        when (arrayDate[1] == '04' || arrayDate[1] == '06' ||  arrayDate[1] == '09' || arrayDate[1] == '11') && arrayDate[0] > 30 then  false
        when (arrayDate[2] % 4 != 0 && arrayDate[1] == '02') && arrayDate[0] > 28 then  false
        when (arrayDate[2] % 4 == 0 && arrayDate[1] == '02') && arrayDate[0] > 29 then  false
        when arrayDate[2] > requiredYear || arrayDate[2] < 1890 then  false
        else
          true
          @showParentsEmail(arrayDate[2])
    else
      false

  showParentsEmail: (year) ->
    if (@currentDate.getFullYear() - year) <= 12
      @parentsEmail.show()
    else
      @parentsEmail.hide()
      @parentsEmail.find('input').val('')
      @parentsEmail.find('input').removeClass('invalid')