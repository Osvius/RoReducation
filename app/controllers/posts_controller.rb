class PostsController < ApplicationController
  attr_reader :post, :posts
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!

  # def initialize(post)
  #   @post = post
  # end

  def admin_list
    authorize Post
  end

  def index
    @posts = Post.all
    authorize @posts
  end

  def show
  end

  def new
    @post = Post.new
    authorize @post
  end

  def edit
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    authorize @post
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def post_params
    params.require(:post).permit(:title, :text, :user_id)
  end

end