# == Schema Information
#
# Table name: homepages
#
#  id             :integer          not null, primary key
#  created_at     :datetime
#  updated_at     :datetime
#  subdomain_name :string(255)
#  hoa_id         :integer
#

class Homepage < ActiveRecord::Base
  belongs_to :hoa
end
