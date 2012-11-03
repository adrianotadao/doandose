class window.Site
  constructor: ->


    $('.about_us').click => @openIframe('quem_somos')

  iframeDefault: ->
    {
      autoSize: false,
      fixed: true,
      height: 634,
      margin: [10, 0, 0, 0],
      minHeight: 634,
      minWidth: 651,
      padding: 0,
      scrolling: 'no',
      width: 651,

      afterLoad: ->
        height = Math.max($(window).height(), 650)
        $('body').css({height: "#{height}px"})
        $('#content').css({height: '100%', overflow: 'hidden'})
        $('embed, object').css({ visibility: 'hidden' })

      beforeClose: ->
        $('body').css({height: ''})
        $('#content').css({height: '', overflow: ''})
        $('embed, object').css({ visibility: 'visible' })

      helpers:
        overlay:
            opacity: 0.7,
            css:
              'background-color': '#DDD'
    }

  openIframe: (url) =>
    fancyBoxProperties =
      href: "http://#{location.host}/#{url}/"
      type: 'iframe'

    $.fancybox $.extend(@iframeDefault(), fancyBoxProperties)