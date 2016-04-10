
angular.module 'Search', [
  'ngCookies'
]

SearchCtrl = ($scope, $timeout, $http, $cookies)->
  
  $scope.executedSearch = false
  time = false
  $scope.displaySearch = false

  # @private
  # Verify cookie data if new search or
  # set cookie data
  manipulateCookies = ->
    if $cookies.get('searchDate')
      relative = Date.now() - (5 * 60 * 1000) # 5 minutes

      # remove the cookie if search is older than 5 minutes
      $cookies.remove 'search' if relative > $cookies.get('searchDate')
    $cookies.put('searchDate', Date.now())

  # @private
  # Send search consulting
  doSearch = ->
    return unless $scope.s
    do manipulateCookies
    $http.get("/articles.json?s=#{$scope.s}").then (response)->
      $scope.results = response.data
      $scope.displaySearch = false
      # Enabled display not found if 0 records
      $scope.displayNotFound = $scope.results.length == 0 && $scope.s.length > 0
    , ->
      $scope.displaySearch = false
      console.error arguments

  # Observer "s" model
  $scope.$watch 's', ->
    $scope.displaySearch = !! $scope.s
    $scope.results = []
    $scope.displayNotFound = false
    $scope.executedSearch = true if !! $scope.s
    
    # reset timeout if no executed
    $timeout.cancel time if time    
    time = $timeout ->
      do doSearch
    , 300


SearchCtrl.$inject = '$scope $timeout $http $cookies'.split ' '
angular.module('Search').controller 'SearchCtrl', SearchCtrl