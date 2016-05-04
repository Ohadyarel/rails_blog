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
    if !params[:user][:blog_title].blank? && !params[:user][:name].blank? && !params[:user][:email].blank? && !params[:user][:password].blank?
      if User.where(email: params[:user][:email].downcase).first == nil
        @user = User.new(blog_title: params[:user][:blog_title], name: params[:user][:name], email: params[:user][:email].downcase, password: params[:user][:password])
        @user.blog_cat = "General"
        @user.save
        log_in @user
        redirect_to user_path(@user)
      else
        flash[:alert] = "A user with that email already exists"
        redirect_to new_user_path
      end
    else
      flash[:alert] = "Please fill in all the fields above."
      redirect_to new_user_path
    end
  end

  def edit
    @update = current_user
  end

  def update
    if !params[:user][:blog_title].blank? && !params[:user][:name].blank? && !params[:user][:email].blank? && !params[:user][:password].blank?
      if User.where(email: params[:user][:email].downcase) == nil
        User.update(current_user[:id], blog_title: params[:user][:blog_title])
        User.update(current_user[:id], name: params[:user][:name])
        User.update(current_user[:id], password: params[:user][:password])
        User.update(current_user[:id], email: params[:user][:email])
        flash[:notice] = "Your profile was updated successfully."
      elsif current_user.email == params[:user][:email]
        User.update(current_user[:id], blog_title: params[:user][:blog_title])
        User.update(current_user[:id], name: params[:user][:name])
        User.update(current_user[:id], password: params[:user][:password])
        flash[:notice] = "Your profile was updated successfully."
      else
        flash[:alert] = "A user with that email already exists"
      end
    else
      flash[:alert] = "Update failed. Please make sure none of the fields were left empty"
    end
    redirect_to edit_user_path
  end

  def destroy
    Post.where(user_id: current_user.id).each do |post|
      post.delete
      post.comments.delete
    end
    Comment.where(user_id: current_user.id).each do |comment|
      comment.delete
    end
    User.find(current_user.id).delete
    log_out
    redirect_to root_path
  end
end
