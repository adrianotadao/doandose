class window.Addressable
  constructor: ->
    new Mask()
    @postalCode = $('.postal_code')
    @street = $('.street')
    @neighborhood = $('.neighborhood')
    @city = $('.city')
    @state = $('.state')
    @number = $('.number')
    @lat = $('.lat')
    @lng = $('.lng')
    @error = false

    @gmap = new AddressableGmap
      map: 'gmap'
      lat: @lat.val()
      lng: @lng.val()

    @postalCode.focusout =>
      @getAddress()
      @number.focus()

    @number.focusout => @searchMapCoordinates(@parseNumberAddress())

    @callbacks()

  setAddressByMarker: (location) ->
    addressComponents = location.result.address.address_components

    @setAddress
      number: addressComponents[0].long_name
      street: addressComponents[1].long_name
      neighborhood: addressComponents[2].long_name
      city: addressComponents[3].long_name
      state: addressComponents[4].long_name
      postalCode: addressComponents[6].long_name
      lat: location.result.lat
      lng: location.result.lng

  setAddressByInput: (location) ->
    addressComponents = location.result.address.address_components

    @setAddress
      street: addressComponents[0].long_name
      neighborhood: addressComponents[1].long_name
      city: addressComponents[2].long_name
      state: addressComponents[3].long_name
      lat: location.result.lat
      lng: location.result.lng

  setAddress: (options) ->
    @number.val(options.number) if options.number
    @street.val(options.street) if options.street
    @neighborhood.val(options.neighborhood) if options.neighborhood
    @city.val(options.city) if options.city
    @state.val(options.state) if options.state
    @postalCode.val(options.postalCode) if options.postalCode
    @lat.val(options.lat) if options.lat
    @lng.val(options.lng) if options.lng

  getAddress: ->
    $.ajax
      dataType: 'script'
      url: "http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep=#{@postalCode.val()}"
      beforeSend: => @addLoading()
      success: =>
        if resultadoCEP['resultado'] == '1'
          @searchMapCoordinates(@parseCepAddress(resultadoCEP))
        else
          @insertError()
      complete: => @removeLoading()

  searchMapCoordinates: (address) ->
    @gmap.searchMapCoordinates(address)

  parseCepAddress: (result) ->
    "#{ unescape(result['tipo_logradouro']) }: #{ unescape(result['logradouro']) }, " +
    "#{ unescape(result['bairro']) }, " +
    "#{ unescape(result['cidade']) }, " +
    "#{ unescape(result['uf']) }"

  parseNumberAddress: ->
    "#{ @number.val() }, #{ @street.val() }, #{ @city.val().replace('Rua: ', '') }, #{ @state.val() }"

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

  callbacks: ->
    $(@gmap).bind 'addressComplete', (e, location) =>
      @setAddressByMarker(location)

    $(@gmap).bind 'addressCoordinatesComplete', (e, location) =>
      @setAddressByInput(location)