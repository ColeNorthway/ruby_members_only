class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [ :new, :create ]

  def new
    # Just serves the form to login
    # Was placed here instead of running default for skip_before_action
  end

  def create
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      cookies.permanent.encrypted[:clubhouse_ticket] = user.id
      user.update(remember: cookies.encrypted[:clubhouse_ticket])
      redirect_to posts_path
    else
      flash.now[:error] = "Error Invalid Username or Password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(id: cookies.encrypted[:clubhouse_ticket])
    cookies.delete(:clubhouse_ticket)
    user&.update(remember: nil)

    redirect_to posts_path
  end
end
