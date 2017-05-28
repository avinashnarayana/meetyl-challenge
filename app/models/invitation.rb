class Invitation < ApplicationRecord
  # model association
  belongs_to :meeting

  # validation
  validates_presence_of :meeting_id, :invitee_id
end
