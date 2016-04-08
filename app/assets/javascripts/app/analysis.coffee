

angular.module 'Analysis', []

AnalysisCtrl = ($scope, $timeout, $http)->
  $http.get('/analysis/data.json').then (response)->
    $scope.results = response.data
  , ->
    console.error arguments


AnalysisCtrl.$inject = '$scope $timeout $http'.split ' '
angular.module('Analysis').controller 'AnalysisCtrl', AnalysisCtrl