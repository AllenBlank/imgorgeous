angular.module('imgorgeous').config ($routeProvider) ->
  $routeProvider
  .when '/', 
    templateUrl: '/app/posts/index.html'
    controller:  'postsController'
    action:      'index'
  .when '/posts', 
    templateUrl: '/app/posts/index.html'
    controller:  'postsController'
    action:      'index'
  .when '/posts/:type/:id', 
    templateUrl: '/app/posts/show.html'
    controller:  'postsController'
    action:      'show'
  .otherwise
    redirectTo: '/'