# == Schema Information
#
# Table name: hoas
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  subdomain_name    :string(255)
#  subscription_type :string(255)      default("basic")
#  subscribed_until  :datetime
#  address           :string(255)
#  city              :string(255)
#  postal_code       :string(255)
#  kvk               :string(255)
#  account_nr        :string(255)
#  account_owner     :string(255)
#

require 'test_helper'

class HoaTest < ActiveSupport::TestCase
  test 'validations' do
    are_attrs_validated?(Hoa,[:name])
  end
end
