require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase
  test 'validations' do
    are_attrs_validated?(Post,[:title])
  end
end
