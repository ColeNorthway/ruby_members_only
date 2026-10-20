class UsersController < ApplicationController
  skip_before_action :authenticate, only: [ :new, :create  ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      cookies.permanent.encrypted[:clubhouse_ticket] = @user.id
      @user.remember = cookies.encrypted[:clubhouse_ticket]
      @user.update(remember: cookies.encrypted[:clubhouse_ticket])
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(cookies.encrypted[:clubhouse_ticket])
  end

  def edit
    @user = User.find(cookies.encrypted[:clubhouse_ticket])
  end

  def update
    @user = User.find(cookies.encrypted[:clubhouse_ticket])
    if @user.update(password_params)
      flash[:success] = "Successfully updated user profile"
      redirect_to posts_path
    else
      render :edit, status: :unprocessable_entity
    end
end

  def destroy
    @user = User.find(cookies.encrypted[:clubhouse_ticket])
    @user.destroy
    cookies.delete(:clubhouse_ticket)
    flash[:success] = "Sorry to see you go"
    redirect_to posts_path
  end

  private

  def user_params
    params.expect(user: [ :username, :password, :password_confirmation ])
  end

  def password_params
    params.expect(user: [ :username, :password, :password_confirmation, :password_challenge ]).with_defaults(password_challenge: "")
  end
end
