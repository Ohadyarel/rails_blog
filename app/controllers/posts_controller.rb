class PostsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    if !params[:post][:title].blank? && !params[:post][:desc].blank? && !params[:post][:body].blank? && logged_in?
      @post = Post.create(title: params[:post][:title], desc: params[:post][:desc], body: params[:post][:body], user_id: current_user.id)
      redirect_to post_path(@post)
    else
      flash[:alert] = "Please fill in all the fields above."
      redirect_to new_post_path
    end
  end

  def destroy
  end
end
