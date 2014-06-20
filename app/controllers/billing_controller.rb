class BillingController < ApplicationController
  before_filter :authenticate_user!
  
  def new
  end

  def index
    @payments = current_user.hoa.payments.includes(:user).where(paid: true).order('updated_at DESC')
    authorize self
  end

  def renew_subscription
    amount = 25

    # Create a new payment for mollie
    mollie = MolliePayment.
      create_payment(amount, confirm_payment_url)

    # Set the payment in the db
    payment = current_user.hoa.payments.new \
      amount: amount * 100, 
      order_id: mollie.metadata.order_id, 
      payment_id: mollie.id.to_s,
      user_id: current_user.id

    puts 'payment created'
    if payment.save
      redirect_to MolliePayment.url(mollie)
    else
      redirect_to billing_path
    end
  end

  def confirm_payment
    payment = current_user.hoa.payments.last
    if MolliePayment.paid?(payment.payment_id) && payment.paid == false
      payment.paid = true
      increase_subscription
      payment.save
      redirect_to billing_path, notice: "Betaling gelukt!"
    else
      redirect_to billing_path, alert: "Betaling afgebroken."
    end
  end

  private

  def increase_subscription
    if current_user.hoa.subscribed_until
      current_user.hoa.subscribed_until += 1.month
    else
      current_user.hoa.subscribed_until = 1.month.from_now
    end
    current_user.hoa.subscription_type = 'standard'
    current_user.hoa.save
  end
end
