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

    @number.focusout => @gmap.searchMapCoordinates('number', @parseNumberAddress())

    @callbacks()

  setAddressOne: (location) ->
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

  setAddressTwo: (location) ->
    addressComponents = location.result.address.address_components

    options = {}
    options.street = addressComponents[0].long_name if addressComponents[0]
    options.neighborhood = addressComponents[1].long_name if addressComponents[1]
    options.city = addressComponents[2].long_name if addressComponents[2]
    options.state = addressComponents[3].long_name if addressComponents[3]
    options.postalCode = addressComponents[5].long_name if addressComponents[5]
    options.lat = location.result.lat
    options.lng = location.result.lng

    @setAddress(options)

  setAddress: (options) ->
    if options.number
      @number.val(options.number)

    if options.street
      @street.val(options.street)

    if options.neighborhood
      @neighborhood.val(options.neighborhood)

    if options.city
      @city.val(options.city)

    if options.state
      @state.val(options.state)

    if options.postalCode
      @postalCode.val(options.postalCode)

    @lat.val("#{if options.lat then options.lat else ''}")
    @lng.val("#{if options.lng then options.lng else ''}")

  getAddress: ->
    $.ajax
      dataType: 'script'
      url: "http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep=#{@postalCode.val()}"
      beforeSend: => @addLoading()
      success: =>
        if resultadoCEP['resultado'] == '1'
          @gmap.searchMapCoordinates('postalCode', @parseCepAddress(resultadoCEP))
        else
          @insertError()
      complete: => @removeLoading()

  parseCepAddress: (result) ->
    "#{ unescape(result.tipo_logradouro) }: #{ unescape(result.logradouro) }, " +
    "#{ unescape(result.bairro) }, " +
    "#{ unescape(result.cidade) }, " +
    "#{ unescape(result.uf) }"

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
      @setAddressOne(location)

    $(@gmap).bind 'postalCodeAddressCoordinatesComplete', (e, location) =>
      @setAddressTwo(location)

    $(@gmap).bind 'numberAddressCoordinatesComplete', (e, location) =>
      @setAddressOne(location)