class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to posts_path
    else
      flash.now[:error] = "Error Invalid Username or Password"
      render :new, status: :unprocessable_entity
    end
  end
end
