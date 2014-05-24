class StatisticsController < ApplicationController
  def user_count
    msg = { count: User.count, data: [{timestamp: Time.now, value: User.count}]}
    respond_to do |format|
      format.json { render json: msg}
      format.text { render text: User.count}
    end
  end

  def hoa_count
    msg = { count: Hoa.count, data: [{timestamp: Time.now, value: Hoa.count}]}
    respond_to do |format|
      format.json { render json: msg}
      format.text { render text: Hoa.count}
    end
  end
end
