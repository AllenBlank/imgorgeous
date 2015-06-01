class Image
  constructor: (json) ->
    @id = json.id
    @title = json.title
    @description = json.description
    @date = json.datetime
    @animated = json.animated
    if @animated then @url = json.webm else @url = json.link
    @url = @url.replace('\\','')

class Post
  constructor: (json) ->
    @id = json.id
    @title = json.title
    if json.is_album then type = '/album/' else type = '/image/'
    @url = '#/posts' + type + @id
    if json.cover then cover = json.cover else cover = @id
    @previewImage = 'http://i.imgur.com/' + cover + 'b.jpg'
    @images = []
    if json.images?
      @images.push new Image(element) for element in json.images
    else if json.type
      @images.push new Image(json)
    @comments = []
    if json.comment_preview? then @comments = json.comment_preview
      

class PostService
  @$inject: ['$http']
  
  constructor: (@http) ->
    @extend = (response, b, c) ->
      response = angular.fromJson(response)
      data = response.data
      if data.constructor is Array
        posts = []
        for obj in data
          post = new Post(obj)
          posts.push post
        posts
      else
        new Post(data)
    @config = 
      method: 'GET'
      url: 'https://api.imgur.com/3/gallery'
      headers: 
        Authorization: 'Client-ID 93113798061328f'
      transformResponse: @extend

  all: ->
    @http(@config)
  find: (id, type) ->
    params = $.extend(true, {}, @config)
    params.url = params.url + '/' + type + '/' + id
    @http(params)
    
    
angular.module('imgorgeous')
.service('Post', PostService)