class UsersController < ApplicationController
  def show
    @user = user_id.find(params[:id])
    @blogs_submitted = @user.blogs
      limit(6).order("blogs.id DESC")
    @blogs_voted_on = @user.blogs_voted_on
      limit(6).order("votes.id DESC")
  end
end
