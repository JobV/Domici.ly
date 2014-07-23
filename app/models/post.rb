# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  hoa_id     :integer
#

class Post < ActiveRecord::Base
  include Trackable

  validates :title, presence: true

  # Associations
  belongs_to :user
  belongs_to :hoa

  # Comments
  acts_as_commentable

  has_many :collaborations, as: :collaborable
end
