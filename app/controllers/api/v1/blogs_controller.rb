class Api::V1::BlogsController < Api::V1::BaseController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
    render json: @blogs
  end

  def show
    render json: @blog
  end

  def create
    @blog = Blog.new(blog_params)

    if @blog.save
      format.json { render :show, status: :created, location: @blog }
    else
      format.json { render json: @blog.errors, status: :unprocessable_entity }
    end
  end

  def update
    if @blog.update(blog_params)
      format.json { render :show, status: :ok, location: @blog }
    else      
      format.json { render json: @blog.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @blog.destroy
    format.json { head :no_content }
  end

  private
  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:body, :title)
  end
end