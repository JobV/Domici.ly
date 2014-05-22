class StatisticsController < ApplicationController
  def user_count
    msg = { :users => "#{User.count}" }
    respond_to do |format|
      format.json { render json: msg}
    end
  end

  def hoa_count
    msg = { :hoas => "#{Hoa.count}" }
    respond_to do |format|
      format.json { render json: msg}
    end
  end
end
