
angular.module 'Analysis', []

AnalysisCtrl = ($scope, $timeout, $http)->
  $scope.page = 'relevant'

  # Get Relevant analysis
  $scope.pageRelevant = ->
    $scope.page = 'relevant'
    $scope.results = []
    $http.get('/analysis/data.json').then (response)->
      $scope.results = response.data
    , ->
      console.error arguments

  # Get Search not found
  $scope.pageNotFound = ->
    $scope.page = 'not_found'
    $scope.results = []
    $http.get('/analysis/not_found.json').then (response)->
      $scope.results = response.data
    , ->
      console.error arguments

  # Delete all search analysis
  $scope.resetStats = ->
    $http.delete('analysis').then (response)->
      do $scope.pageRelevant
    , ->
      console.error arguments

  # Default data is Relevant Searchs
  do $scope.pageRelevant

AnalysisCtrl.$inject = '$scope $timeout $http'.split ' '
angular.module('Analysis').controller 'AnalysisCtrl', AnalysisCtrl