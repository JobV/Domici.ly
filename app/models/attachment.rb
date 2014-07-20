# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  alert_id   :integer
#  attachment :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Attachment < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  belongs_to :alert

  def name
    return File.basename(URI.parse(attachment.to_s).path)
  end
end
