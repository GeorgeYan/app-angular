angular.module('Blog').factory('postData', ['$http', ($http) ->

  postData =
    data:
      posts: [{title: 'Loading', contents: ''}]
    isLoaded: false

  postData.loadPosts = (deferred) ->
    if !postData.isLoaded
      $http.get('./posts.json').success( (data) ->
        postData.data.posts = data
        postData.isLoaded = true
        console.log('Successfully loaded posts.')
        if deferred
          deferred.resolve()
      ).error( ->
        console.error('Failed to load posts.')
        if deferred
          deferred.resolve()
      )
    else
      if deferred
        deferred.resolve()

  postData.refresh = ->
    $http.get('./posts.json').success( (data) ->
      postData.data.posts = data
      console.log('Successfully refreshed posts.')
    ).error( ->
      console.error('Failed to refresh posts.')
    )


  postData.createPost = (newPost) ->
    # Client-side data validation
    if newPost.newPostTitle == '' or newPost.newPostContents == ''
      alert('Neither the Title nor the Body are allowed to be left blank.')
      return false

    # Create data object to POST
    data =
      new_post:
        title: newPost.newPostTitle
        contents: newPost.newPostContents

    # Do POST request to /posts.json
    $http.post('./posts.json', data).success( (data) ->

      # Add new post to array of posts
      postData.data.posts.push(data)
      console.log('Successfully created post.')

    ).error( ->
      console.error('Failed to create new post.')
    )

    return true


  postData.updatePost = (postId, postData) ->
    # Client-side data validation
    if postData.title == '' or postData.contents == ''
      alert('Neither the Title nor the Body are allowed to be left blank.')
      return false

    # Create data object to POST
    data =
      post_id: postId
      edit_post:
        title: postData.title
        contents: postData.contents

    # Do PUT request to /posts.json  mind coffeescript #{} must be in ""
    $http.put("./posts/#{postId}.json", data).success( (data) ->

      # Add new post to array of posts
      #postData.data.posts.push(data)
      console.log('Successfully updated the post.')

    ).error( ->
      console.error('Failed to update the post.')
    )

    return true

  return postData

])
