angular.module('imgorgeous')
.controller 'itemsController', ($routeParams, $route, $scope, Item) ->
  
  @beforeActions = 
    setItem: ['show','new','edit']
  
  @actions =
    index: ->
      Item.all().success (data) ->
        $scope.items = []
        for item in data
          $scope.items.push Item.extend(item)
    show: ->
    new: ->
      $scope.createItem = (item) ->
        Item.create(item).success (data) ->
          window.location = Item.extend( data.item ).showPath
        $scope.item = {}
    edit: ->
      $scope.updateItem = (item) ->
        Item.update(item).success (data) ->
          window.location = item.showPath
     
  @privateMethods =
    setItem: ->
      if $routeParams.id?
        Item.find($routeParams.id).success (data) ->
          $scope.item = Item.extend(data)
      else
        $scope.item = {}
      
  $scope.$on "$routeChangeSuccess", =>
    for method, actions of @beforeActions
      if 0 <= $.inArray( $route.current.action, actions )
        @privateMethods[method]()
    @actions[$route.current.action]()
  