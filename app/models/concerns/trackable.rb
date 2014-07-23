# public_activity -> set current_user as owner by default
# only track creation events
module Trackable
  extend ActiveSupport::Concern

  included do
    include PublicActivity::Model
    tracked only: [:create],
      owner:  Proc.new{ |controller, model| controller && controller.current_user },
      hoa_id: Proc.new{ |controller, model| controller && controller.current_user.hoa.id }
  end
end
