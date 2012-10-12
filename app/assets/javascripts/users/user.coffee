class window.User extends window.UserBase
  userPotision: ->
    [@lat(), @lng()]

  lat: ->
    return unless $.cookies.get('lat')?
    $.cookies.get('lat')

  lng: ->
    return unless $.cookies.get('lng')?
    $.cookies.get('lng')

window.user = new User() unless window.user || window.top.user