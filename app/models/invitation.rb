class Invitation < ApplicationRecord
  before_create :set_defaults
  # model association
  belongs_to :meeting
  belongs_to :invitee, class_name: "User"

  # validation
  validates_presence_of :meeting_id, :invitee_id
  validates :response, inclusion: { in: ["Accepted", "Declined"], message: "%{value} is not a valid response" }, on: :update
  def set_defaults
    self.response ||= "No Response Yet"
  end
end
