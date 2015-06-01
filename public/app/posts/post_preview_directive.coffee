angular.module('imgorgeous')
.directive 'postPreview', ->
  restrict: 'E'
  templateUrl: '/app/posts/_post_preview.html'
  scope:
    post: '='
  link: (scope, element)->
    element.on 'click', ->