module MolliePayment
  require "Mollie/API/Client"
  @mollie       = Mollie::API::Client.new
  @mollie.setApiKey Rails.application.secrets.mollie_api_key
  

  def self.create_payment(amount, redirect_url)
    @mollie.payments.create \
      amount:         amount,
      description:    "Domici.ly Abonnement",
      redirectUrl:    redirect_url,
      metadata:       { order_id: self.order_id },
      method:         Mollie::API::Object::Method::IDEAL
  end

  # Returns the url to send the user to pay.
  def self.url(payment)
    payment.getPaymentUrl
  end

  # Does a new call to check if subscription is paid.
  def self.paid?(payment_id)
    self.get_payment(payment_id).paid?
  end

  def self.get_payment(payment_id)
    @mollie.payments.get payment_id
  end

  # Generate a semi-unique order id
  def self.order_id
    Time.now.to_i
  end
end

# 1. Enter amount of months
# 2. Pay required amount using iDeal
# 3. Done!
   

# Op je webserver zet je een betaling klaar bij Mollie door onze API aan te roepen met het af te rekenen bedrag, de omschrijving van de transactie en de URL waar we de klant naar toe moeten sturen na de betaling. Je ontvangt een ID en een URL waar je de klant naar toe kunt sturen. Nadat je het ID van de betaling opgeslagen hebt bij de order, stuur je de klant naar de URL die wij gegeven hebben (dit is de paymentUrl).

# De klant komt op onze website, waar hij / zij een betaalmethode kan kiezen en af kan rekenen.

# Wanneer het afrekenen voltooid is, zullen wij een webhook aanroepen en je website informeren met de nieuwe status van de betaling. Deze webhook kun je instellen via het Mollie Beheer of bij het aanmaken van de betaling meegeven. Je kan daarna de order op betaald zetten et cetera.

# Nadat de nieuwe status is verwerkt, zullen we de klant terugsturen naar je website. Je kan de URL waar de klant heen gestuurd moet worden opgeven bij het aanmaken van de betaling.

# Wanneer de klant weer op je website terug is, toont je aan de klant de status van zijn of haar betaling en order.
