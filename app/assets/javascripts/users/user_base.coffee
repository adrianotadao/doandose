class window.UserBase
  signedIn: ->
    @validCookie('email')? &&
      @validCookie('lat')? &&
      @validCookie('lng')?

  logout: ->
    $.ajax
      type: 'get'
      url: '/sair/'
      error: (e) =>
        alert 'logout não foi feito com sucesso!'
      success: (e) =>
        $(this).trigger('signedOut')

  validCookie: (name) ->
    cookie = $.cookies.get(name)
    cookie? && cookie != '' && cookie != undefined