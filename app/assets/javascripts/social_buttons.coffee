class window.SocialButtons
  constructor: ->
    @links = $('.social_links a')

    @links.mouseenter (event) =>
      @onMouseEnter(event)

    @links.mouseleave (event) =>
      @onMouseLeave(event)

    @links.click (e) =>
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
    $('#person_user_attributes_email').val attr.email if $('#person_user_attributes_email').val() == ''
    $('#person_name').val attr.username if $('#person_name').val() == ''

    $('form#new_person .form.user').append("<input type='hidden' name='person[user_attributes][authentications_attributes][0][provider]' value='#{attr.authentication.provider}'>
                              <input type='hidden' name='person[user_attributes][authentications_attributes][0][uid]' value='#{attr.authentication.uid}'>")

    @check(attr)

  check: (attr) ->
    attr = attr.authentication.provider if attr.authentication
    $(".social_links a.#{attr}")
      .css('opacity', '0.2')
      .addClass('selected')
      .append("<span class='check'></span>")
      .attr('href', '#')
      .unbind('click')

  setSocialNetwork: (attr) ->
    return unless attr
    attr = attr.split(',')
    for i in attr
      @check(i)