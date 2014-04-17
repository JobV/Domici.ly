# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean
#  first_name             :string(255)
#  last_name              :string(255)
#  hoa_id                 :integer
#  invitation_token       :string(255)
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  invitations_count      :integer          default(0)
#

class User < ActiveRecord::Base
  rolify

  # unread gem
  acts_as_reader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :async

  has_many :posts
  has_many :alerts

  belongs_to :hoa
  has_many :participations
  has_many :events, through: :participations

  attr_reader :role

  def name
    return first_name unless first_name.blank?
    return_name
  end

  def full_name
    return "#{first_name} #{last_name}" unless first_name.blank? | last_name.blank?
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
