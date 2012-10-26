class window.BaseForm
  constructor: (options) ->
    @options = options
    @fields = options.validates
    @buttonSubmit = $(@options.form).find('input:submit')
    @submitted = false

    for field in @fields
      $(field).bind('complete', (e) =>
        $(@options.form).submit() if @submitted && @isAllValid()
      )

    $(document).ready =>
      $(@options.form).submit (e) =>
        if @submitted
          return false
        else if @valid()
          @submitted = true
          @disabledButton()
          return true
        else
          @refuse()
          return false

  valid: ->
    status = true
    setFocusTo = undefined
    for field in @fields
      unless field.validate()
        status = false
        setFocusTo = field unless setFocusTo?

    setFocusTo.setFocus() if setFocusTo?
    return status

  isAllValid: ->
    status = true
    for field in @fields
      status = false unless field.isValid()
    return status

  disabledButton: ->
    disableSubmit $(@options.form).find('input:submit')
    $(@options.form).find('input:submit').attr 'value', "aguarde..."

  refuse: ->
    @buttonSubmit.stop().animate({marginLeft: '+10px'}, 50, ->
      $(this).stop().animate({marginLeft: '-10px'}, 100, ->
        $(this).stop().animate({marginLeft: '0px'}, 50, ->
          $(this).stop().animate({marginLeft: '+5px'}, 50, ->
            $(this).stop().animate({marginLeft: '-5px'}, 50, ->
              $(this).stop().animate({marginLeft: '-5px'}, 50, ->
                $(this).stop().animate({marginLeft: '0px'}, 20, ->
                )
              )
            )
          )
        )
      )
    )