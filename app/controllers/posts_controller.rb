class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    if @post = Post.create(post_params)
      flash[:success] = "Your post has been created!"
      redirect_to @post
    else
      flash.now[:alert] = "Your new post couldn't be created! Please check the form"
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated!"
      redirect_to @post
    else
      flash.now[:alert] = "Update failed. Please check the form."
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Post deleted!"
      redirect_to root_path
    else
      flash.now[:alert] = "Delete failed."
      render :show
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:caption, :image)
  end
end
