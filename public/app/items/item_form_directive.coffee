angular.module('imgorgeous')
.directive 'itemform', ->
  restrict: 'E'
  templateUrl: '/app/items/_form.html'
  scope:
    item:  '='
    submit: '='
    title: '@'
  controller: ->
  link: (scope, element)->
    element.on 'click', ->