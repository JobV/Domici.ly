require 'test_helper'

class HoaTest < ActiveSupport::TestCase
  test 'validations' do
    are_attrs_validated?(Hoa,[:name])
  end
end
