class CollaborationPolicy < ApplicationPolicy
  attr_reader :user, :collaboration

  def initialize(user, collaboration)
    @user = user
    @collaboration = collaboration
  end

  def destroy?
    collaboration.user == user
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
