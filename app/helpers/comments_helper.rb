module CommentsHelper
  def resource_from_comment(comment)
    eval(comment.commentable_type).find(comment.commentable_id)
  end
end
