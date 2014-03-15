class Alert < ActiveRecord::Base
  resourcify
  
  belongs_to :user
  belongs_to :hoa
end
