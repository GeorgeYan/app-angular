@IndexCtrl = ($scope, $location, $http, postData) ->
  $scope.data = postData.data

  postData.loadPosts(null)

  $scope.viewPost = (postId) ->
    $location.url('/post/'+postId)

  $scope.navNewPost = ->
    $location.url('/post/new')

  $scope.numPerPage = 5
  $scope.noOfPages = Math.ceil(myData.count() / $scope.numPerPage)
  $scope.currentPage = 1

  $scope.setPage = ->
    $scope.data = postData.get( ($scope.currentPage - 1) * $scope.numPerPage, $scope.numPerPage)

  $scope.$watch( 'currentPage', $scope.setpage )

  $scope.delete = (postId) ->
    if confirm("Are you sure?")
      $http.delete("./posts/#{postId}.json").success(  ->
        console.log('Successfully delete the post.')
        postData.refresh()
      ).error( ->
        console.error('Failed to delete the post.')
      )

    return true


@IndexCtrl.$inject = ['$scope', '$location', '$http', 'postData']
