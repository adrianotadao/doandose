class window.Steps
  constructor: ->
    $('#next-step').click (e) => @changeStep(e)

  changeStep: (e) =>
    console.log e