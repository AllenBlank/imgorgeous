class Image
  constructor: (json) ->
    @id = json.id
    @title = json.title
    @description = json.description
    @date = json.datetime
    @animated = json.animated
    if json.height * json.width > 10000000
      @url = '/app/img/gigantic.png'
    else
      if @animated then @url = json.webm else @url = json.link
      

class Post
  constructor: (json, page=1) ->
    @id = json.id
    @title = json.title
    if json.is_album then type = '/album/' else type = '/image/'
    @url = '#/posts' + type + @id + '/1'
    if json.cover then cover = json.cover else cover = @id
    @previewImage = 'http://i.imgur.com/' + cover + 'b.jpg'
    @image_count = json.images_count
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
    @gallery = []

  all: ->
    console.log 'fetching gallery'
    @http(@config)
  find: (id, type) ->
    params = $.extend(true, {}, @config)
    params.url = params.url + '/' + type + '/' + id
    @http(params)
    
    
angular.module('imgorgeous')
.service('Post', PostService)