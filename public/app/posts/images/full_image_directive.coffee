angular.module('imgorgeous')
.directive 'fullImage', ->
  restrict: 'E'
  templateUrl: '/app/posts/images/_full_image.html'
  scope:
    image: '='
  link: (scope, element)->
    image = '<img src="' + scope.image.url + '"></img>'
    video = 
      '<video loop="true" autoplay>' +
      '<source src="' + scope.image.url + '" type="video/webm">' +
      '<source src="' + scope.image.backupUrl + '" type="video/mp4">' +
      '</video>'
    container = element.find('.image-container')
    wrapper = '<a href="' + scope.image.url + '" target="_blank"></a>'
    container.wrap(wrapper)
    container.on 'inview', (e, inView)->
      $this = $(this)
      if inView and not $this.children().length
        if scope.image.animated
          $this.append video
        else
          $this.append image