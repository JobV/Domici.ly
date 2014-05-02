class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def destroy?
    admin_moderator_or_owner?
  end

  def admin_moderator_or_owner?
    user.admin? or user.has_role? :moderator, post.hoa or post.user == user
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
