# == Schema Information
#
# Table name: alerts
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  body        :text
#  severity    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  hoa_id      :integer
#  progress    :string(255)      default("new")
#  assignee_id :integer
#  archived    :boolean          default(FALSE)
#  attachment  :string(255)
#

class Alert < ActiveRecord::Base
  include Readable, Trackable

  # default_scope { where(archived: false) }

  # Validations
  validates :title,
            :user_id,
            :hoa_id,
            :progress,
            presence: true

  # active_admin
  resourcify

  # Acts as taggable on
  # preserve order so that in state, the last is the current state
  acts_as_ordered_taggable # Alias for acts_as_taggable_on :tags
  acts_as_ordered_taggable_on :state

  # Comments
  acts_as_commentable

  belongs_to :user
  belongs_to :assignee, class_name: 'User', foreign_key: :assignee_id
  belongs_to :hoa

  has_many :collaborations, as: :collaborable
  has_many :attachments, dependent: :destroy

  accepts_nested_attributes_for :attachments
  validates_associated :attachments

  def new?
    self.progress == 'new'
  end

  def in_progress?
    self.progress == 'in progress'
  end

  def completed?
    self.progress == 'completed'
  end

    def self.to_csv
    CSV.generate do |csv|
      csv << ['Melding Titel', 'Melding Beschrijving', 'Status', 'Gebruiker','Gemaakt','Reacties']
      all.each do |alert|
        csv << [
          alert.title,
          alert.body,
          alert.progress,
          alert.user.full_name,
          alert.created_at,
          alert.comments.pluck(:comment).join('; ').squish ]
      end
    end
  end
end
