angular.module('imgorgeous')
.directive 'comment', ->
  restrict: 'E'
  templateUrl: '/app/posts/comments/_comment.html'
  scope:
    comment: '='
  link: (scope, element)->