class AlertPolicy < ApplicationPolicy
  attr_reader :user, :alert

  def initialize(user, alert)
    @user = user
    @alert = alert
  end

  def destroy?
    admin_moderator_or_owner?
  end

  def update?
    admin_moderator_or_owner?
  end

  def admin_moderator_or_owner?
    user.admin? or user.has_role? :moderator, alert.hoa or alert.user == user
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
