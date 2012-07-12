class window.SocialButtons
  constructor: ->
    $('ul.social_links li').mouseenter (event) =>
      @onMouseEnter(event)
    
    $('ul.social_links li').mouseleave (event) =>
      @onMouseLeave(event)

    $('ul.social_links li a').click (e) =>
      @open $(e.currentTarget).attr('href')
      e.stopPropagation()
      return false

  onMouseEnter: (e) ->
    $(e.currentTarget).animate({'marginTop': '-=8px'}, 100)

  onMouseLeave: (e) ->
    $(e.currentTarget).animate({'marginTop': '+=8px'}, 100)

  open: (url) ->
    width = 800
    height = 500
    left = (screen.width/2)-(width/2)
    top = (screen.height/2)-(height/2)
    window.open(url, 'authPopup', "menubar=no,toolbar=no,status=no,width=#{width},height=#{height},toolbar=no,left=#{left},top=#{top}")

  fill: (attr) ->
    $('#person_user_attributes_email').val attr.email
    
    $('form#new_person').append("<input type='hidden' name='users_user[authentications_attributes][0][provider]' value='#{attr.authentication.provider}'>
                              <input type='hidden' name='users_user[authentications_attributes][0][uid]' value='#{attr.authentication.uid}'>")