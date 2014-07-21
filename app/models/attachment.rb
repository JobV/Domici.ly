# == Schema Information
#
# Table name: attachments
#
#  id           :integer          not null, primary key
#  alert_id     :integer
#  attachment   :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  content_type :string(255)
#  file_size    :integer
#

class Attachment < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  belongs_to :alert
  belongs_to :hoa
  validates :attachment,
    presence: true,
    file_size: {
      maximum: 20.megabytes.to_i
    }

  before_save :update_attachment_attributes

  def name
    return File.basename(URI.parse(attachment.to_s).path)
  end

  private

  def update_attachment_attributes
    if attachment.present? && attachment_changed?
      self.content_type = attachment.file.content_type
      self.file_size = attachment.file.size
    end
  end
end
