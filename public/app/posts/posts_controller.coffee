angular.module('imgorgeous')
.controller 'postsController', ($routeParams, $route, $scope, Post, $rootScope, Gallery) ->
  
  @beforeActions = 
    setPosts: ['index']
    setPost: ['show']
  
  @actions =
    index: ->
    show: ->
      setUp = (posts)->
        Gallery.posts = posts
        $scope.posts = posts
        for post, i in $scope.posts
          currentIndex = i if post.id is $routeParams.id
        $scope.next = $scope.posts[currentIndex + 1].url
        $scope.previous = $scope.posts[currentIndex - 1].url
        
      if Gallery.posts?
        setUp(Gallery.posts)
      else
        Post.all().success setUp
     
  @privateMethods =
    setPosts: ->
      Post.all().success (response) ->
        $scope.posts = response
        Gallery.posts = response
    setPost: ->
      if $routeParams.id?
        Post.find($routeParams.id, $routeParams.type).success (data) ->
          perpage = 100
          $scope.post = data
          end = $routeParams.page * perpage
          start = end - perpage
          pageUrl = (num) ->
            url = window.location.href
            url = url.split '/'
            url[url.length - 1] = num
            url.join '/'
          $scope.post.images = $scope.post.images[start...end]
          $scope.nextImages = pageUrl(+$routeParams.page + 1) if $scope.post.images.length >= end
          $scope.previousImages = pageUrl(+$routeParams.page - 1) if start > 0
      else
        $scope.post = {}
      
  $scope.$on "$routeChangeSuccess", =>
    for method, actions of @beforeActions
      if 0 <= $.inArray( $route.current.action, actions )
        @privateMethods[method]()
    @actions[$route.current.action]()
  