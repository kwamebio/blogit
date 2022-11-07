class VotesController < ApplicationController
  before_action :ensure_login
  def create
    @blog =Blog.find(params[:blog_id])
    if @vote = @blog.votes.create(user_id: @current_user)
      respond_to do |format|
      format.html { redirect_to @blog, notice: 'Vote was successful'}
      format.js {}
    end 
    end
  end
end
