window.fbShare = (path) ->
  popupWidth  = 660
  popupHeight = 360

  centerWidth  = (window.screen.width - popupWidth) / 2
  centerHeight = (window.screen.height - popupHeight) / 2

  defaultHost = 'staging.doando.se'
  url = "http://www.facebook.com/sharer/sharer.php?u=http://#{defaultHost}/#{path}/"

  popup = window.open(url, 'sharer', "toolbar=no, width=#{popupWidth}, height=#{popupHeight}, left=#{centerWidth}, top=#{centerHeight}")

  popup.focus()
  return popup.name