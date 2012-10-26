class window.Mask
  constructor: ->
    $('#person_birthday').mask('9?9/99/9999')
    $('.postal_code').mask('9?9.999-999')
    $('#company_cnpj').mask('9?9.999.999/9999-99')
    $('#person_weight, #person_height').maskMoney({thousands:"."})
    $('#person_contact_attributes_ddd_phone, #person_contact_attributes_ddd_cellphone').mask('(99)')

    $('#person_birthday') .datepicker()
    $('#person_weight, #person_height').spinner()