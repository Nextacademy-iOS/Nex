class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @blog = Blog.find(params[:blog_id])
    @comments = @blog.comments
    render json: @comments
  end

  def show
    render json: @comment
  end

  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.new(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else      
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    render nothing: true, status: :no_content
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :author)
  end
end