class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :alerts

  belongs_to :hoa

  def name
    return first_name if first_name
    return last_name if last_name
    return email if email
    return 'undefined'
  end
end
