angular.module('imgorgeous')
.directive 'fullImage', ->
  restrict: 'E'
  templateUrl: '/app/posts/images/_full_image.html'
  scope:
    image: '='
  link: (scope, element)->
    image = '<img src="' + scope.image.url + '"></img>'
    video = '<video src="' + scope.image.url + '" loop="true" autoplay></video>'
    container = element.find('.image-container')
    container.on 'inview', (e, inView)->
      $this = $(this)
      if inView and not $this.children().length
        if scope.image.animated
          $this.append video
        else
          $this.append image
      else if !inView
        $this.height($this.height()) if $this.width()
        $this.text('')