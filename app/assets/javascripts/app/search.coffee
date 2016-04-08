

angular.module 'Search', [
  
]

SearchCtrl = ($scope, $timeout, $http)->

  time = false
  $scope.displaySearch = false

  doSearch = ->
    return unless $scope.s
    $http.get("/articles.json?s=#{$scope.s}").then (response)->
      $scope.results = response.data
      $scope.displaySearch = false
    , ->
      $scope.displaySearch = false
      console.error arguments

  $scope.$watch 's', ->
    $scope.displaySearch = !! $scope.s
    $scope.results = []
    $timeout.cancel time if time
    time = $timeout ->
      do doSearch
    , 300


SearchCtrl.$inject = '$scope $timeout $http'.split ' '
angular.module('Search').controller 'SearchCtrl', SearchCtrl