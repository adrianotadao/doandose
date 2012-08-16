class window.Steps
  constructor: ->
    $('#next_step').click (e) => @chagenStep(e)

  changeStep: (e) ->
    console.log e