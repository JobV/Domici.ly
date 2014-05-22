class HoaPolicy < ApplicationPolicy
  attr_reader :user, :hoa

  def initialize(user, hoa)
    @user = user
    @hoa = hoa
  end

  def index?
    user.admin?
  end

  def new?
    user.admin? or user.hoa == nil
  end

  def show?
    user.admin? or user.hoa == hoa
  end

  # def create
  #   user.admin? or user.hoa == nil
  # end

  def members?
    user.hoa == hoa
  end

  def destroy?
    user.admin?
  end

  def update?
    admin_moderator_or_owner?
  end

  def admin_moderator_or_owner?
    user.admin? or user.has_role? :moderator, hoa.hoa or hoa.user == user
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
