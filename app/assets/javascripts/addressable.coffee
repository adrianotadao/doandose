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
      @clearFields()
      @getAddress()
      @number.focus()

    @number.focusout =>
      @gmap.searchMapCoordinates('number', @parseNumberAddress())

    @callbacks()

  setAddressOne: (location) ->
    addressComponents = location.result.address.address_components

    options = {}
    options.number = addressComponents[0].long_name if addressComponents[0]
    options.street = addressComponents[1].long_name if addressComponents[1]
    options.neighborhood = @neighborhoodVal if @neighborhoodVal
    options.city = addressComponents[3].long_name if addressComponents[3]
    options.state = addressComponents[4].long_name if addressComponents[4]
    options.lat = location.result.lat
    options.lng = location.result.lng

    @setAddress(options)

  setAddressTwo: (location) ->
    addressComponents = location.result.address.address_components

    options = {}
    options.street = addressComponents[0].long_name if addressComponents[0]
    options.neighborhood = @neighborhoodVal if @neighborhoodVal
    options.city = addressComponents[1].long_name if addressComponents[1]
    options.state = addressComponents[2].long_name if addressComponents[2]
    options.lat = location.result.lat
    options.lng = location.result.lng

    @setAddress(options)

  setAddress: (options) ->
    if options.number && @number.val() == ''
      @number.val(options.number)

    if options.street && @street.val() == ''
      @street.val(options.street)

    if options.neighborhood && @neighborhood.val() == ''
      @neighborhood.val(options.neighborhood)

    if options.city && @city.val() == ''
      @city.val(options.city)

    if options.state && @state.val() == ''
      @state.val(options.state)

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
          @neighborhoodVal = unescape(resultadoCEP.bairro)
        else
          @insertError()
      complete: => @removeLoading()

  parseCepAddress: (result) ->
    "#{ unescape(result.tipo_logradouro) } #{ unescape(result.logradouro) }, " +
    "#{ unescape(result.cidade) } - " +
    "#{ unescape(result.uf) }"

  parseNumberAddress: ->
    "#{ @street.val() } #{ @number.val() }, #{ @city.val() } - #{ @state.val() }"

  addLoading: =>
    @removeLoading()
    @postalCode.after("<div id='load' style='position: absolute; top: 1384px; left: 730px'>
                        <img alt='Load' class='load' src='/assets/load.gif' style='width: 20px'>
                      </div> ")

  removeLoading: ->
    $('#load').remove()

  insertError: =>
    @removeError()
    @postalCode.after("<div id='tooltip' class='right invalid' style='position: absolute; height: 11px; top: 1384px; left: 580.5px;'>
                      <div class='message'>Cep invalido</div>")
    @error = true

  removeError: =>
    if @error
      $('.error_postal_code').remove()
      @error = false

  clearFields: ->
    @street.val('')
    @neighborhood.val('')
    @city.val('')
    @state.val('')
    @number.val('')
    @lat.val('')
    @lng.val('')

  callbacks: ->
    $(@gmap).bind 'addressComplete', (e, location) =>
      @setAddressOne(location)

    $(@gmap).bind 'postalCodeAddressCoordinatesComplete', (e, location) =>
      @setAddressTwo(location)

    $(@gmap).bind 'numberAddressCoordinatesComplete', (e, location) =>
      @setAddressOne(location)