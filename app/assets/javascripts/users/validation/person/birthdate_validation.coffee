class window.BirthdateValidation extends BaseValidation
  constructor: ->
    super('#person_birthday')
    @field.mask('99/99/9999')

  run: ->
    unless @validationDate()
      @setStatus('error', 'Data inválida')
    else
      @setStatus('valid')

  validationDate: =>
    expReg = /^(([0-2]\d|[3][0-1])\/([0]\d|[1][0-2])\/[1-2][0-9]\d{2})$/
    arrayDate = @field.val().split('/')
    @currentDate = new Date
    requiredYear = @currentDate.getFullYear() - 17

    if @field.val().match(expReg) && arrayDate[1] != '00' && arrayDate[0] != '00'
      switch
        when (arrayDate[1] == '04' || arrayDate[1] == '06' ||  arrayDate[1] == '09' || arrayDate[1] == '11') && arrayDate[0] > 30 then  false
        when (arrayDate[2] % 4 != 0 && arrayDate[1] == '02') && arrayDate[0] > 28 then  false
        when (arrayDate[2] % 4 == 0 && arrayDate[1] == '02') && arrayDate[0] > 29 then  false
        when arrayDate[2] > requiredYear || arrayDate[2] < 1890 then  false
        else
          true
    else
      false