class PostsController < ApplicationController
  skip_before_action :authenticate, only: [ :index, :show ]

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
    @post.user = User.find(cookies.encrypted[:clubhouse_ticket])
    if @post.save
      redirect_to @post
    else
      flash.now[:error] = "Cannot process post"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
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
