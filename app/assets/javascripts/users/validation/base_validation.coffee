class window.BaseValidation
  constructor: (field) ->
    @field = $(field)
    @status = ''
    @message = undefined
    @visited = false

    @lastValue = ''
    @value = $(field).val()

    @field.focusin =>
      @openToolTip(@message) if @visited || @message?

    @field.focusout =>
      @validate()

    @field.bind('keyup keydown', (e) =>
      clearInterval(@interval)
      @interval = window.setTimeout(=>
        @validate()
      , 3000)
    )

  addLoading: ->
    @removeLoading()
    Tooltip.close()
    @field.css('float', 'left')
    @field.after("<div class='loading' style='width: 20px; height: 20px; display: inline-block; margin: 6px; float: left'></div>")

  removeLoading: ->
    $('.loading').remove()
    @field.css('float', 'none')

  run: ->
    throw('You should implement this method')

  validate: ->

    if @changed() || !@visited
      @lastValue = @field.val()
      @visited = true
      @run()

    @isValid()

  isValid: ->
    return @status == 'valid' || @status == 'pending'

  changed: ->
    @lastValue != @field.val()

  openToolTip: ->
    console.log @message?
    if @message?
      @field.tooltip({ message: @message, class: 'invalid' })
    @visited = true

  removeToolTip: ->
    @field.tooltip({ message: null, class: 'valid' })

  setStatus: (status, message) ->
    @status = status
    @message = message

    switch @status
      when 'error'
        @openToolTip()
        $(this).trigger('complete')
      when 'pending'
        @addLoading()
      else
        $(this).trigger('complete')
        @removeToolTip()

  setFocus: ->
    $(@field).focus()