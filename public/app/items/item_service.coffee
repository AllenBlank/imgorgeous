class ItemService
  @$inject: ['$http']
  
  constructor: (@http) ->

  all: ->
    @http.get '/items'
  find: (id) ->
    @http.get '/items/' + id
  create: (item) ->
    @http.post '/items', item
  update: (item) ->
    @http.put '/items/' + item.id, item
  destroy: (item) ->
    @http.delete '/items/' + item.id
  extend: (item) ->
    item.showPath = '#/items/' + item.id
    item.editPath = item.showPath + '/edit'
    item
    
    
angular.module('imgorgeous')
.service('Item', ItemService)