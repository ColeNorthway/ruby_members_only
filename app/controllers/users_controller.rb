class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  def edit
  end

  private

  def user_params
    params.expect(user: [ :username, :password, :password_confirmation ])
  end
end
