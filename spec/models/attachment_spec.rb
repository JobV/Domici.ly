# == Schema Information
#
# Table name: attachments
#
#  id           :integer          not null, primary key
#  alert_id     :integer
#  attachment   :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  content_type :string(255)
#  file_size    :integer
#

require 'rails_helper'

RSpec.describe Attachment, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
