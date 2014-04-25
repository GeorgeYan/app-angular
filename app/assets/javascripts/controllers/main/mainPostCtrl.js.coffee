@PostCtrl = ($scope, $routeParams, $location, $q, postData) ->

  $scope.data =
    postData: postData.data
    currentPost:
      title: 'Loading..'
      contents: ''

  $scope.data.postId = $routeParams.postId

  $scope.navNewPost = ->
    $location.url('/post/new')

  $scope.navHome = ->
    $location.url('/')

  $scope.editPost = (postId) ->
    $location.url('/post/edit/'+postId)

  $scope.updatePost = (postId) ->
    postData.updatePost(postId, $scope.data.currentPost)
    $location.url('/')
    postData.refresh()

  $scope.cancel = (postId) ->
    $location.url('/post/'+postId)

  # This will be run once the loadPosts successfully completes (or immediately
  # if data is already loaded)
  $scope.prepPostData = ->
    post = _.findWhere(postData.data.posts, { id: parseInt($scope.data.postId) })
    $scope.data.currentPost.title = post.title
    $scope.data.currentPost.contents = post.contents

  # Create promise to be resolved after posts load
  @deferred = $q.defer()
  @deferred.promise.then($scope.prepPostData)

  # Provide deferred promise chain to the loadPosts function
  postData.loadPosts(@deferred)


@PostCtrl.$inject = ['$scope', '$routeParams', '$location','$q' ,'postData']
