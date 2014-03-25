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
  belongs_to :user
  belongs_to :hoa
end
