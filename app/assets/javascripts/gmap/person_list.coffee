class window.PersonList
  _list = []

  @list: ->
    _list

  @add: (person) ->
    PersonList.list().push person