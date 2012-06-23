class window.UserForm
  constructor: ->
    new Validations()
    @infield()

  infield: ->
    $('form#new_person input').each ->
      unless $(this).val()
        console.log $("form#new_person.simple_form div#user dl.form dt label")
        $(this).focus -> $("form#new_person .#{$(this).attr('id').replace('users_user_', '')} dt label").removeClass("inlined").addClass('focus') 
        $(this).keypress -> $("form#new_person .#{$(this).attr('id').replace('users_user_', '')} dt label").removeClass("focus").addClass("has-text")
        $(this).blur -> $("form#new_person .#{$(this).attr('id').replace('users_user_', '')} dt label").removeClass("has-text").removeClass("focus") if $(this).val() == ''
   
