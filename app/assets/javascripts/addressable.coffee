class window.Addressable
  constructor: ->
    @gmap = new UserGmap()

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

    @number.focusout => @searchMapCoordinates()

    $(@gmap).bind 'addressComplete', (e, location) =>
      @parseAddress(location)

  parseAddress: (location) ->
    addressComponentes = location.result.address.address_components

    @number.val(addressComponentes[0].long_name) if addressComponentes[0]
    @street.val(addressComponentes[1].long_name) if addressComponentes[1]
    @neighborhood.val(addressComponentes[2].long_name) if addressComponentes[2]
    @city.val(addressComponentes[3].long_name) if addressComponentes[3]
    @state.val(addressComponentes[4].long_name) if addressComponentes[4]
    @postalCode.val(addressComponentes[6].long_name) if addressComponentes[6]

  getAddress: ->
    $.ajax
      dataType: 'script'
      url: "http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep=#{@postalCode.val()}"
      beforeSend: => @addLoading()
      success: =>
        if resultadoCEP['resultado'] == '1'
          @setAddress(resultadoCEP)
          @searchMapCoordinates()
        else
          @insertError()
      complete: => @removeLoading()

  searchMapCoordinates: ->
    @gmap.searchMapCoordinates("#{@number.val()}, #{@street.val()}, #{@city.val().replace('Rua: ', '')}, #{@state.val()}")

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