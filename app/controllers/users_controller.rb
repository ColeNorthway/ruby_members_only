class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      cookies.permanent.encrypted[:clubhouse_ticket] = @user.id
      @user.remember = cookies.encrypted[:clubhouse_ticket]
      @user.update(remember: cookies.encrypted[:clubhouse_ticket])
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(cookies.encrypted[:clubhouse_ticket])
  end

  def edit
  end

  private

  def user_params
    params.expect(user: [ :username, :password, :password_confirmation ])
  end
end
