class PostsController < ApplicationController
  def index
    @posts = Post.all.sample(10)
    redirect_to root_path if !logged_in?
  end

  def show
    @current_post = Post.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where(post_id: params[:id]).all
    redirect_to root_path if !logged_in?
  end

  def new
    @post = Post.new
    redirect_to root_path if !logged_in?
  end

  def create
    if !params[:post][:title].blank? && !params[:post][:desc].blank? && !params[:post][:body].blank? && logged_in?
      @post = Post.create(title: params[:post][:title], desc: params[:post][:desc], img_url: params[:post][:img_url], body: params[:post][:body], user_id: current_user.id)
      redirect_to post_path(@post)
    else
      flash[:alert] = "Please fill in all the fields above."
      redirect_to new_post_path
    end
  end

  def destroy
    Post.find(params[:id]).comments.delete
    Post.find(params[:id]).delete
    redirect_to user_path(current_user)
  end
end
