module Readable
  extend ActiveSupport::Concern

  included do
    has_many :readings, as: :readable
  end

  def read?(user)
    ! self.unread?(user)
  end

  def unread?(user)
    ! self.readings.map { |r| r.user_id = user.id  }.any?
  end

  def mark_as_read!(user)
    self.readings.create(user: user)
  end

  module ClassMethods
    def unread_by(user)
      Reading.where(user: user, readable_type: self.class.name)
    end
  end
end
