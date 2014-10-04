class Appointment < ActiveRecord::Base
  validates :appointment_type, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :vehicle_make, presence: true
  validates :vehicle_year, presence: true, numericality: { only_integer: true, greater_than: 1800, less_than_or_equal_to: Time.new.year }
  validates :vehicle_issue, presence: true, if: :repair_type_appointment?
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :date, presence: true
  validates :time, presence: true

  validate :date_is_valid
  validate :time_is_valid

  def repair_type_appointment?
    appointment_type == 'repair'
  end

  def date_is_valid
    if date.nil?
      errors.add(:date, 'must be provided')
      return
    end
    errors.add(:date, 'must be in the future') if Date.tomorrow > date
    errors.add(:date, 'cannot be on a Sunday') if date.wday == 0
    errors.add(:date, 'cannot be on a holiday') unless Holidays.on(date, :ca).blank?
  end

  def time_is_valid
    return false if date.nil? or time.nil?

    # Check if the time is within our working hours
    actual_time = time.change(year: date.year, month: date.month, day: date.day)
    store_hours = {
      opening: Time.utc(date.year, date.month, date.day, 8, 0),
      closing: Time.utc(date.year, date.month, date.day, 17, 30),
      sat_closing: Time.utc(date.year, date.month, date.day, 14, 30)
    }

    if date.wday >= 1 and date.wday <= 5
      errors.add(:time, 'must be from 8:00 to 17:30') if actual_time < store_hours[:opening] or actual_time > store_hours[:closing]
    elsif date.wday == 6
      errors.add(:time, 'must be from 8:00 to 14:30') if actual_time < store_hours[:opening] or actual_time > store_hours[:sat_closing]
    end

    # Check if the time has been used already (30 minute intervals)
    current_appointments = self.class.where(date: date).map { |x| x.time } # Times are saved to 2000-01-01 for the date
    errors.add(:time, 'has already been booked') if current_appointments.include? time.change(year: 2000, month: 1, day: 1)
  end

  def name
    "#{last_name}, #{first_name}"
  end

  def vehicle
    "#{vehicle_year} #{vehicle_make}"
  end
end
