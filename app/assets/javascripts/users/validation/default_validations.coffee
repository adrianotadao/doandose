window.is_blank = (field) ->
    alert field.val()
    if field.val() == ""
      return true
    else
      return false

window.not_number = (field) ->
  if /[0-9]/.test($(field).val())
    return false
  else
    return true