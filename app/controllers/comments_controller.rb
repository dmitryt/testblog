class CommentsController < ApplicationController
  before_filter :authenticate_user!
  expose_decorated(:comment)
  expose_decorated(:post)
  
  def index
  end

  def new
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
    comment.post = post
    comment.user = current_user
    if comment.save
      redirect_to post
    else
      render :new
    end
  end

  def vote_up
    comment.vote_up current_user
    redirect_to post
  end

  def vote_down
    comment.vote_down current_user
    redirect_to post
  end

  def reset_abusing
    if comment.post.owner? current_user
      comment.abusive = false
      comment.save
    end
    redirect_to post
  end

end
