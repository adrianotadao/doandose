class window.UserBase
  signedIn: ->
    $.cookies.get('username')? &&
      $.cookies.get('lat')? &&
      $.cookies.get('lng')?

  logout: ->
    $.ajax
      type: 'get'
      url: '/sair/'
      error: (e) =>
        alert 'logout não foi feito com sucesso!'
      success: (e) =>
        $(this).trigger('signedOut')