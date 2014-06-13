class BillingController < ApplicationController
  def new
    @pay = MolliePayment.new(amount: 25, redirect_url: root_url)
    @payment = @pay.payment
  end

  def index
  end
end
