class window.Addressable
  constructor: ->
    @coordinates = new Coordinates()

    @postalCode = $('.postal_code')
    @street = $('.street')
    @neighborhood = $('.neighborhood')
    @city = $('.city')
    @state = $('.state')
    @number = $('.number')
    @lat = $('.lat')
    @lng = $('.lng')
    @error = false

    @postalCode.focusout =>
      @getAddress()
      @number.focus()

  getAddress: ->
    $.ajax
      dataType: 'script'
      url: "http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep=#{@postalCode.val()}"
      beforeSend: => @addLoading()
      success: =>
        if resultadoCEP['resultado'] == '1'
          @setAddress(resultadoCEP)
          @coordinates.getCoordinates()
          @gmap = new Gmap(@lat.val(), @lng.val())
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
    @postalCode.after("<div class='loading' style='width: 32px; height: 32px; display: inline-block; margin: 6px; background: url('loading.gif')'></div>")

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