class window.Menu
  constructor: (element) ->
    $(element)
      .accordion
          header: "> div > h3"
          collapsible: true

      .sortable
          axis: "y"
          handle: "h3"
          stop: ( event, ui ) ->
              ui.item.children( "h3" ).triggerHandler( "focusout" )