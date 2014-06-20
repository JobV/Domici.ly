class BillingControllerPolicy < ApplicationPolicy
  attr_reader :user, :ctrlr

  def initialize(user, ctrlr)
    @user = user
    @ctrlr = ctrlr
  end

  def index?
    moderator_or_admin?
  end

  def renew_subscription?
    moderator_or_admin?
  end

  def confirm_payment?
    moderator_or_admin?
  end
  
  def moderator_or_admin?
    @user.has_role?(:moderator, @user.hoa) | @user.admin
  end  

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
