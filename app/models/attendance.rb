class Attendance < ActiveRecord::Base
  belongs_to :user
  validate :valid_date?

  def valid_date?
    begin
      Date.parse working_day.to_s
    rescue
      errors.add(:working_day, 'invalid date format')
    end
  end
end
