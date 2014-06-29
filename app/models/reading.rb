class Reading < ActiveRecord::Base
  belongs_to :readable, polymorphic: true
  belongs_to :user

  validates :user, presence: true, uniqueness: { scope: :readable }
end
