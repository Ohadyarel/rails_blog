class CommentsController < ApplicationController
  def create
  	if !params[:comment][:body].blank? && logged_in?
  		@comment = Comment.create(user_id: current_user.id, post_id: params[:comment][:post_id], body: params[:comment][:body])
  		redirect_to post_path(@comment.post)
  	else
  		flash[:alert] = "Please write your comment before clicking the submit button"
  		redirect_to post_path(params[:comment][:post_id])
  	end
  end

  def destroy
    Comment.find(params[:id]).delete
    redirect_to post_path(params[:post_id])
  end
end
