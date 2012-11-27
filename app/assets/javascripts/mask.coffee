class window.Mask
  constructor: ->
    @mask()
    @date()
    @dateYearsOld()
    @spinnerDecimal()
    @spinnerNumber()

  mask: ->
    $('#person_birthday, #campaign_expired_at').mask('9?9/99/9999')
    $('.postal_code').mask('9?9.999-999')
    $('#company_cnpj').mask('9?9.999.999/9999-99')
    $('#person_weight, #person_height').maskMoney({thousands:"."})
    $( "#person_birthday" ).datepicker("option", "dateFormat", 'dd/mm/yy')


  dateYearsOld: ->
    @currentDate = new Date
    ageMin = @currentDate.getFullYear() - 17
    ageMax = @currentDate.getFullYear() - 90

    $('#person_birthday').datepicker
      dateFormat: "dd/mm/yy",
      changeMonth: true,
      changeYear: true,
      yearRange: "#{ageMax}:#{ageMin}"

  date: ->
    $('#campaign_expired_at').datepicker
      dateFormat: "dd/mm/yy",
      changeMonth: true,
      changeYear: true,

  spinnerDecimal: ->
    $('#person_weight, #person_height').spinner(
      step: 0.01,
      numberFormat: "n"
    )

  spinnerNumber: ->
    $('#campaign_quantity, #notification_quantity').spinner(
      step: 1,
      numberFormat: "n"
    )