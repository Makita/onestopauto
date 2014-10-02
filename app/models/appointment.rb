class Appointment < ActiveRecord::Base
  validates :appointment_type, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :vehicle_make, presence: true
  validates :vehicle_year, presence: true, numericality: { only_integer: true, greater_than: 1800, less_than_or_equal_to: Time.new.year }
  validates :billing_address, presence: true
  validates :billing_phone, presence: true
  validates :card_number, presence: true
  validates :csc, presence: true, numericality: { only_integer: true, greater_than: 99, less_than: 10000 }, length: { in: 3..4 }
  validates :cardholder_name, presence: true

  validate :vehicle_issue_presence_when_repairing

  def vehicle_issue_presence_when_repairing
    if appointment_type == 'repair' and vehicle_issue.blank?
      errors.add(:vehicle_issue, "can't be blank when making a repair appointment")
    end
  end

  def name
    "#{last_name}, #{first_name}"
  end
end
