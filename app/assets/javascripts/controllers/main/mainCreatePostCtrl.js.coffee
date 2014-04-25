@CreatePostCtrl = ($scope, $location, $q, postData) ->

  $scope.data = postData.data
  postData.loadPosts(null)

  $scope.formData =
    newPostTitle: ''
    newPostContents: ''

  $scope.navNewPost = ->
    $location.url('/post/new')

  $scope.navHome = ->
    $location.url('/')

  $scope.createPost = ->
    postData.createPost($scope.formData)
    $location.url('/')

  $scope.clearPost = ->
    $scope.formData.newPostTitle = ''
    $scope.formData.newPostContents = ''

@CreatePostCtrl.$inject = ['$scope', '$location', '$q',  'postData']

