class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :alerts

  belongs_to :hoa

  def name
    return first_name unless first_name.blank?
    return_name
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name && last_name
    return_name
  end

  def return_name
    return last_name unless last_name.blank?
    return email if email
    'undefined'
  end

  def hoa_name
    return hoa.name if hoa
    'JAXONS'
  end
end
