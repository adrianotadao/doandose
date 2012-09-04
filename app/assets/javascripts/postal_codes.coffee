class window.PostalCodes
  alert: $('.alert')
  input_clear: $('.clear_input')
  preloader: $('.preloader')
  postal_code: $('.postal_code')
  street: $('.street')
  neighborhood: $('.neighborhood')
  city: $('.city')
  state: $('.state')
  number: $('.number')
  complement: $('#customer_address_attributes_complement')

  constructor: ->
    new Mask()
    $.ajax
      type: 'get'
      dataType: "jsonp"
      url: "http://cep.republicavirtual.com.br/web_cep.php"
      data: "cep=" + $('.postal_code') + "&formato=javascript"
      beforeSend: (data) ->
        console.log 'aguarde ...', data
      success: (data) ->
        console.log xml
      complete: (data) ->
        console.log 'tudo certo', XMLHttpRequest
    # @postal_code.focusout =>
    #   if $.trim(@postal_code.val()) != '' && $.trim(@postal_code.val()) != '__.___-___'
    #     @progress()
    #     $.getScript "http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep=#{$('.postal_code').val()}", =>
    #       if resultadoCEP['resultado'] && resultadoCEP['bairro'] != ''
    #         @setAddress()
    #         @sucess()
    #       else
    #         @fail()
    #   else
    #     @principle()

    @number.focusout =>
        @complement.focus()

  progress: ->
    @preloader.show()
    @input_clear.hide()
    @alert.hide()

  fail: ->
    @preloader.hide()
    @input_clear.hide()
    @postal_code.focus()
    @clear()
    @alert.show()

  sucess: ->
    @preloader.hide()
    @input_clear.show()
    @alert.hide()
    @number.focus()

  principle: ->
    @preloader.hide()
    @input_clear.hide()
    @alert.hide()
    @clear()

  clear: ->
    @postal_code.val('')
    @street.val('')
    @neighborhood.val('')
    @city.val('')
    @state.val('')
    @alert.hide()
    @input_clear.hide()

  setAddress: ->
    @street.val(unescape(resultadoCEP['tipo_logradouro'])+': '+unescape(resultadoCEP['logradouro']))
    @neighborhood.val(unescape(resultadoCEP['bairro']))
    @city.val(unescape(resultadoCEP['cidade']))
    @state.val(unescape(resultadoCEP['uf']))
