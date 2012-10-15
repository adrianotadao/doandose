class window.Addressable
  constructor: (userPosition)->
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

    @gmap = new AddressableGmap(userPosition)

    @postalCode.focusout =>
      @getAddress()
      @number.focus()

    @number.focusout => @searchMapCoordinates(@parseNumberAddress())

    @callbacks()

  setAddressByMarker: (location) ->
    addressComponents = location.result.address.address_components

    options = {}
    options.number = addressComponents[0].long_name if addressComponents[0]
    options.street = addressComponents[1].long_name if addressComponents[1]
    options.neighborhood = addressComponents[2].long_name if addressComponents[2]
    options.city = addressComponents[3].long_name if addressComponents[3]
    options.state = addressComponents[4].long_name if addressComponents[4]
    options.postalCode = addressComponents[6].long_name if addressComponents[6]
    options.lat = location.result.lat
    options.lng = location.result.lng

    @setAddress(options)

  setAddressByInput: (location) ->
    addressComponents = location.result.address.address_components

    options = {}
    options.street = addressComponents[0].long_name if addressComponents[0]
    options.neighborhood = addressComponents[1].long_name if addressComponents[1]
    options.city = addressComponents[2].long_name if addressComponents[2]
    options.state = addressComponents[3].long_name if addressComponents[3]
    options.lat = location.result.lat
    options.lng = location.result.lng

    @setAddress(options)

  setAddress: (options) ->
    @number.val("#{if options.number then options.number else ''}")
    @street.val("#{if options.street then options.street else ''}")
    @neighborhood.val("#{if options.neighborhood then options.neighborhood else ''}")
    @city.val("#{if options.city then options.city else ''}")
    @state.val("#{if options.state then options.state else ''}")
    @postalCode.val("#{if options.postalCode then options.postalCode else ''}")
    @lat.val("#{if options.lat then options.lat else ''}")
    @lng.val("#{if options.lng then options.lng else ''}")

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