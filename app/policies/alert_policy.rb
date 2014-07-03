class AlertPolicy < ApplicationPolicy
  attr_reader :user, :alert

  def initialize(user, alert)
    @user = user
    @alert = alert
  end

  def assign?
    admin_moderator_or_maintenance?
  end

  def show?
    admin_moderator_or_owner? or collaborator? or is_assigned?
  end

  def destroy?
    admin_moderator_or_owner?
  end

  def update?
    admin_moderator_or_owner? or is_assigned?
  end

  def part_of_hoa?
    user.hoa == alert.hoa or alert.user == user or user.admin
  end

  def is_assigned?
    alert.assignee == user
  end

  def collaborator?
    @alert.collaborations.where(user: @user).any?
  end

  def admin_moderator_or_maintenance?
    @user.admin? | @user.has_role?(:moderator, @user.hoa) | @user.has_role?(:maintenance, @user.hoa)
  end

  def admin_moderator_or_owner?
    @user.admin? or @user.has_role? :moderator, alert.hoa or alert.user == @user
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
