$ = jQuery

class window.Tooltip
  @open: (options, input) ->
    settings = $.extend { message: '', class: null }, options

    if settings.message?
      @container().find('.message').text(settings.message)
      @container().show()
    else
      @close()

    @container().removeClass('valid').removeClass('invalid')
    @container().addClass(settings.class)
    input.removeClass('valid').removeClass('invalid')
    input.addClass(settings.class)
    @setPosition(input)

  @setPosition: (input) ->

    if input.attr('type') == 'hidden'
      input = input.parent('dd').find('span').last()
    else if input.attr('type') == 'checkbox'
      label = $("label[for=\'#{input.attr 'id'}\']")
      input = label if label?

    left = ( input.offset().left + input.outerWidth() ) - 180
    top = input.offset().top + (input.outerHeight() - @container().outerHeight())/2

    if left + @container().outerWidth() > $(document).width()
      left = input.offset().left - @container().outerWidth()
      @container().removeClass('right').addClass('left')
    else
      @container().removeClass('left').addClass('right')

    @container().css({ top: top, left: left })

  @close: ->
    $('#tooltip').remove()

  @container: ->
    selector = $('#tooltip')
    if selector.length == 0
      selector = $("<div id='tooltip' style='display: none; position: absolute; height: 11px'>
                      <div class='message'>
                      </div>
                    </div>").appendTo('body')
      $('body').append(selector)

    return selector

$.fn.extend
  tooltip: (options) ->
    return @each -> Tooltip.open options, $(this)