class CommentDecorator < Draper::Decorator
  decorates :comment
  delegate_all
  
  def post
    object.post
  end
end
