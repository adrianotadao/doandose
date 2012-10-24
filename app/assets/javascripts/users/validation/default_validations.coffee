window.is_blank = (field) ->
    if field.val() == ''
      return true
    else
      return false

window.not_number = (field) ->
  console.log /[0-9-]/.test(field.val()), '========='
  if /[0-9]/.test(field.val())
    return false
  else
    return true