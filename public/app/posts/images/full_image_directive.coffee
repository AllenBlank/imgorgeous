angular.module('imgorgeous')
.directive 'fullImage', ->
  restrict: 'E'
  templateUrl: '/app/posts/images/_full_image.html'
  scope:
    image: '='
  link: (scope, element)->
    image = '<img src="' + scope.image.link + '"></img>'
    video = '<video loop="true" poster="' + scope.image.link + '" autoplay>'
    if scope.image.webm
      video = video + '<source src="' + scope.image.webm + '" type="video/webm">'
    if scope.image.mp4
      video = video + '<source src="' + scope.image.mp4 + '" type="video/mp4">'
    video = video + image + '</video>'
    container = element.find('.image-container')
    wrapper = '<a href="' + scope.image.link + '" target="_blank"></a>'
    container.wrap(wrapper)
    container.on 'inview', (e, inView)->
      $this = $(this)
      if inView and not $this.children().length
        if scope.image.animated
          $this.append video
        else
          $this.append image