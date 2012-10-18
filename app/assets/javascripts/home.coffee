class window.Home
  constructor: (options) ->
    new HomeGmap(options)

    $('span.institutional').click ->
      $("#bloods").hide 'bounce', 1000, callback

    $('span.donor').click ->
      $("#bloods").show 'bounce', 1000,
        $('h4.blood_type').text('Tipo de plasma').text('Tipo de plasma')
        $('span.institutional').css
            opacity: '1'
            cursor: 'pointer'

  callback = ->
    $('h4.blood_type').text('Clicando abaixo:')
    $('span.institutional').css
      opacity: '0.2'
      cursor: 'none'