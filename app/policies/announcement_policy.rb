class AnnouncementPolicy < ApplicationPolicy
  attr_reader :user, :announcement

  def initialize(user, announcement)
    @user = user
    @announcement = announcement
  end

  def new?
    moderator?
  end

  def create?
    moderator?
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  private

  def moderator?
    @user.has_role?(:moderator, @user.hoa) or @user.admin
  end
end
