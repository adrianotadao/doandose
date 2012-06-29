class window.SocialButtons
  constructor: ->
    $('ul.social_links li').mouseenter (event) =>
      @onMouseEnter(event)
    
    $('ul.social_links li').mouseleave (event) =>
      @onMouseLeave(event)
        
  onMouseEnter: (e) ->
    $(e.currentTarget).animate({'marginTop': '-=8px'}, 100)

  onMouseLeave: (e) ->
    $(e.currentTarget).animate({'marginTop': '+=8px'}, 100)