# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  title            :string(50)       default("")
#  comment          :text
#  commentable_id   :integer
#  commentable_type :string(255)
#  user_id          :integer
#  role             :string(255)      default("comments")
#  created_at       :datetime
#  updated_at       :datetime
#  hoa_id           :integer
#

class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment, Trackable

  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  # NOTE: Comments belong to a user
  belongs_to :user
  belongs_to :hoa
end
