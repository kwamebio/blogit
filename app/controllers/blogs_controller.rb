class BlogsController < ApplicationController
  before_action :ensure_login, only: [ :new, :create ]
  def index
    @blogs = Blog.popular
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = @current_user.blogs.build blog_params
    if @blog.save
      flash[:notice] = 'Blog submission succeeded'
      redirect_to blogs_path
    else
      render action: 'new'
    end
  end

  def blog_params
    params.require(:blog).permit(:name, :link, :description)
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def bin 
    @blogs = Blog.upcoming
    render action: "index"
  end

  def fetch_blogs(conditions)
    @blogs = Blog.where(conditions).order("id DESC")
  end

end
