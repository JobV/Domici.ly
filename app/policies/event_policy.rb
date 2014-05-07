class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def show?
    part_of_hoa?
  end

  def destroy?
    admin_moderator_or_owner?
  end

  def update?
    admin_moderator_or_owner?
  end

  def part_of_hoa?
    user.hoa == event.hoa
  end

  def admin_moderator_or_owner?
    user.admin? or user.has_role? :moderator, event.hoa or event.user == user
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
