class Meeting < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?
  
  # model association
  has_many :invitations, dependent: :destroy
  belongs_to :inviter, class_name: "User"
  has_many :invitees, through: :invitations

  # validations
  validates_presence_of :location, :inviter_id, :start_time, :end_time
  validate :start_time_is_valid, :end_time_is_valid
  def end_time_is_valid
    # errors.add(:end_time, 'must be a valid datetime') if ((DateTime.parse(end_time) rescue ArgumentError) == ArgumentError)
    errors.add(:end_time, 'must be after start time') if end_time<=start_time
  end
  def start_time_is_valid
    # errors.add(:start_time, 'must be a valid datetime') if ((DateTime.parse(start_time) rescue ArgumentError) == ArgumentError)
    errors.add(:start_time, 'must be in the future') if start_time<DateTime.now.to_s
  end
  
  def set_defaults
    self.max_size  ||= 0
  end
end
