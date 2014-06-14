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
#  address                :string(255)
#  house_number           :string(255)
#  postal_code            :string(255)
#  phone_number           :string(255)
#  city                   :string(255)
#

class User < ActiveRecord::Base
  # unread gem
  acts_as_reader
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :alerts 
  has_many :announcements
  belongs_to :hoa
  has_many :participations
  has_many :events, through: :participations
  has_many :collaborations

  attr_reader :role
  rolify

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
    'Domici.ly'
  end

  def subdomain
    return hoa.subdomain_name if hoa
    'app'
  end

  def got_started?
    ! first_name.blank? &&
    ! last_name.blank? &&
    ! alerts.last.nil? &&
    address_complete?
  end

  def address_complete?
    ! address.blank? &&
    ! house_number.blank? &&
    ! postal_code.blank?
  end

  def profile_complete_percentage
    steps_completed = 0.0
    attributes = [:address, :house_number, :postal_code, :first_name, :last_name, :phone_number]
    attributes.each do |atr|
      steps_completed += 1 unless self[atr].blank?
    end
    steps_completed += 1 unless alerts.count == 0
    return steps_completed / (attributes.count + 1.0) * 100
  end
end
