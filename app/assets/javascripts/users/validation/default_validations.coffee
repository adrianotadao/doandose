window.not_number = (field) ->
  if /[0-9]/.test($(field).val())
    return false
  else
    return true