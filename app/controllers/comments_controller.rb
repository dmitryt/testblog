class CommentsController < ApplicationController
  before_filter :authenticate_user!
  expose_decorated(:comment)
  expose_decorated(:post)
  
  def index
  end

  def new
    post = PostDecorator.find(params[:post_id])
    @comment = post.comments.build
  end

  def edit
  end

  def update
    if comment.save
      render action: :index
    else
      render :new
    end
  end

  def destroy
    comment.destroy if current_user.commenter? comment
    render action: :index
  end

  def show
  end

  def create
    if @comment.save
      redirect_to post
    else
      render :new
    end
  end

end
