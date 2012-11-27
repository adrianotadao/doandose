class window.RemoveFromErrors
  constructor: ->
    $('input').focusin (e) =>
      name_class = $(e.currentTarget).attr('id')
      $("span.#{@selector(name_class)}").remove()


  selector: (element) ->
    array = element.split('_')
    length_array = array.length

    if length_array == 3 || length_array > 4
      array.slice(-2).join('_')
    else
      array.slice(-1)[0]