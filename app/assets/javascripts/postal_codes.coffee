class window.PostalCodes
  constructor: ->
    @postalCode = $('.postal_code')
    @street = $('.street')
    @neighborhood = $('.neighborhood')
    @city = $('.city')
    @state = $('.state')
    @number = $('.number')
    @error = false

    @postalCode.focusout =>
      @run()
      @number.focus()

  run: ->
    $.ajax
      dataType: "script"
      url: "http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep=#{@postalCode.val()}"
      beforeSend: => @addLoading()
      success: =>
        if resultadoCEP['resultado'] == '1'
          @setAddress(resultadoCEP)
        else
          @insertError()
      complete: => @removeLoading()

  setAddress: (string) ->
    @removeError()
    @street.val("#{ unescape(string['tipo_logradouro']) }: #{ unescape(string['logradouro']) }")
    @neighborhood.val(unescape(string['bairro']))
    @city.val(unescape(string['cidade']))
    @state.val(unescape(string['uf']))

  addLoading: =>
    @removeLoading()
    @postalCode.after("<div class='loading' style='width: 32px; height: 32px; display: inline-block; margin: 6px'></div>")

  removeLoading: ->
    $('.loading').remove()

  insertError: =>
    @removeError()
    @postalCode.after("<div class='error_postal_code'>Cep incorreto.</div>")
    @postalCode.focus()
    @error = true

  removeError: =>
    if @error
      $('.error_postal_code').remove()
      @error = false