class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    if User.where(email: params[:user][:email].downcase) == nil
      @user = User.new(blog_title: params[:user][:blog_title], name: params[:user][:name], email: params[:user][:email].downcase, password: params[:user][:password])
      @user.blog_cat = "General"
      @user.save
      log_in @user
      redirect_to user_path(@user)
    else
      flash[:alert] = "A user with that email already exists"
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
