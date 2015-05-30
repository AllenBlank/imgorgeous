angular.module('Rangular').config ($routeProvider) ->
  $routeProvider
  .when '/', 
    templateUrl: '/app/index.html'
    controller: ->
  .when '/items', 
    templateUrl: '/app/items/index.html'
    controller:  'itemsController'
    action:      'index'
  .when '/items/new', 
    templateUrl: '/app/items/new.html'
    controller:  'itemsController'
    action:      'new'
  .when '/items/:id/edit', 
    templateUrl: '/app/items/edit.html'
    controller:  'itemsController'
    action:      'edit'
  .when '/items/:id', 
    templateUrl: '/app/items/show.html'
    controller:  'itemsController'
    action:      'show'
  .otherwise
    redirectTo: '/'