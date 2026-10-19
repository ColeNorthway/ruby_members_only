class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @post.date = Date.today
    @post.user = User.find(1) # Temporary crutch for testing
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  def update
    @post = Post.find(params[:id])
    @post.date = Date.today
    @post.body = params[:post][:body]
    @post.title = params[:post][:title]

    if @post.save
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
end
