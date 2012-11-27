class window.Menu
  constructor: (element) ->
    tabs = $( element ).tabs()
    tabs.find( ".ui-tabs-nav" ).sortable
        axis: "x",
        stop: ->
            tabs.tabs( "refresh" )