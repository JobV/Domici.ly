class StatisticsController < ApplicationController
  def user_count
    User.count
  end

  def hoa_count
    Hoa.count
  end
end
