# == Schema Information
#
# Table name: payments
#
#  id          :integer          not null, primary key
#  amount      :integer
#  description :string(255)
#  order_id    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  paid        :boolean          default(FALSE)
#  payment_id  :string(255)
#  hoa_id      :integer
#

class Payment < ActiveRecord::Base
  belongs_to :hoa
  belongs_to :user
end
