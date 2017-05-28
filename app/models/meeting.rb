class Meeting < ApplicationRecord
  # model association
  has_many :invitations, dependent: :destroy

  # validations
  validate :end_time_is_valid?,:start_time_is_valid?
  def end_time_is_valid?
    if end_time<=start_time
      errors.add(:end_time, 'must be after start time') 
    end
  end
  def start_time_is_valid?
    if start_time<DateTime.now
      errors.add(:start_time, 'must be in the future')
    end
  end
end
