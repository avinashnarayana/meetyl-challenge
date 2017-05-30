class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :meetings, foreign_key: :inviter_id
  has_many :invitations, foreign_key: :invitee_id
  has_many :invited_meetings, through: :invitations, source: :meeting
  
  # Validations
  validates_presence_of :name, :email, :password_digest
end
