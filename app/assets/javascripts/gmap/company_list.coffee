class window.CompanyList
  _list = []

  @list: ->
    _list

  @add: (company) ->
    CompanyList.list().push company

  @clear: ->
    _list = []