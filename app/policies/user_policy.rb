class UserPolicy < ApplicationPolicy
  attr_reader :user, :subject

  def initialize(user, subject)
    @user = user
    @subject = subject
  end

  def edit?
    user.has_role?(:moderator, subject.hoa) or user.admin
  end

  def update?
    user == subject || user.has_role?(:moderator, subject.hoa) or user.admin
  end

  def show?
    user.hoa == subject.hoa
  end

  def remove_from_hoa?
    user.has_role?(:moderator, subject.hoa) or user.admin
  end

  def change_role?
    user.has_role?(:moderator, subject.hoa) or user.admin
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
