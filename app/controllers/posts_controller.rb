class PostsController < ApplicationController
  respond_to :json

  def index
    # Gather all post data
    posts = Post.paginate(:page => params[:page], :per_page => params[:page_size])

    # Respond to request with post data in json format
    respond_with(posts) do |format|
      format.json { render :json => posts.as_json }
    end
  end

  def create
    # Create and save new post from data receieved from the client
    new_post = Post.new
    new_post.title = params[:new_post][:title][0...250] # Get only first 250 characters
    new_post.contents = params[:new_post][:contents]

    # Comfirm post is valid and save or return HTTP error
    if new_post.valid?
      new_post.save!
    else
      render "public/422", :status => 422
      return
    end

    # Respond with newly created post in json format
    respond_with(new_post) do |format|
      format.json { render :json => new_post.as_json }
    end
  end

  def update
    # Update and save the edit post from data receieved from the client
    edit_post = Post.find(params[:id])
    edit_post.title = params[:edit_post][:title][0...250]
    edit_post.contents = params[:edit_post][:contents]

    if edit_post.valid?
      edit_post.save
    else
      render "public/422", status =>422
      return
    end

    respond_with(edit_post) do |format|
      format.json { render :json => edit_post.as_json }
    end
  end

  def destroy
    # Delete the psot from data receieved from the client
    delete_post = Post.delete(params[:id])

    respond_with(delete_post) do |format|
      format.json { render :json => delete_post.as_json }
    end
  end

end
