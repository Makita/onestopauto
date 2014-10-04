require 'rails_helper'
require 'spec_helper'

RSpec.describe Appointment, :type => :model do
  before { @appointment = build(:appointment) }

  subject { @appointment }

  it {
    should validate_presence_of :appointment_type
    should validate_presence_of :first_name
    should validate_presence_of :last_name
    should validate_presence_of :vehicle_make
    should validate_presence_of :vehicle_year
    should validate_presence_of :address
    should validate_presence_of :phone_number
    should validate_presence_of :date
    should validate_presence_of :time
  }

  context "when appointment type is repair" do
    before { @appointment.assign_attributes({ appointment_type: 'repair', vehicle_issue: nil }) }

    it { expect(@appointment).to be_invalid }
  end

  context "when appointment type is checkup" do
    before { @appointment.appointment_type = 'checkup' }

    it { expect(@appointment).to be_valid }
  end
end
