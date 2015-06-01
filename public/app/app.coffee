angular.module('imgorgeous', ['ngRoute', 'ngSanitize']).config ($sceDelegateProvider) ->
  $sceDelegateProvider.resourceUrlWhitelist [
    'self', 
    'http://i.imgur.com/**'
  ]