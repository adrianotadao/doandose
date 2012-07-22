$ = jQuery

$.fn.extend
	infield: ->
    settings =
      fadeOpacity: 0.5
      fadeDuration: 100
           
    apply = (label, input) ->
      settings = $.extend(settings)
      input = $(input)
      label = $(label)
      
      if input.val()
        label.hide()
      else
        label.show()
        label.css('opacity', 1.0)
              
      input.focusin -> fadeInFocus()
      input.focusout -> checkForEmpty()
      input.keypress (e) -> hideOutFocus(e)
         
      fadeInFocus = -> setOpacity(settings.fadeOpacity) unless input.val()
          
      checkForEmpty = ->
        hideOnChange()
        unless $.trim( input.val() )
          input.val('')
          label.show()
          setOpacity(1.0)
      
      hideOutFocus = (e) ->
        return if e.keyCode == 9 || e.keyCode == 16 || e.keyCode == 8
        label.hide()
        
      hideOnChange = -> label.hide() if input.val()
      setOpacity = (opacity) -> label.stop().animate({ opacity: opacity }, settings.fadeDuration)

    return @each () ->
      labelFor = $(this).attr('for')
      if labelFor
        input = $("##{labelFor}")
        next if input.length == 0
        apply $(this), $(input)
