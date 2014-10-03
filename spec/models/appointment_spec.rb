require 'rails_helper'
require 'spec_helper'

RSpec.describe Appointment, :type => :model do
  before {
    @appointment = Appointment.new
    @appointment.appointment_type = 'repair'
    @appointment.first_name = 'First'
    @appointment.last_name = 'Last'
    @appointment.vehicle_make = 'Make'
    @appointment.vehicle_year = '1984'
    @appointment.billing_address = '1983 Something St.'
    @appointment.billing_phone = '3943939393'
  }

  subject { @appointment }

  it { should validate_presence_of :appointment_type }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :vehicle_make }
  it { should validate_presence_of :vehicle_year }
  it { should validate_presence_of :billing_address }
  it { should validate_presence_of :billing_phone }

  context "when appointment type is repair" do
    it { expect(@appointment).to be_invalid }
  end

  context "when appointment type is checkup" do
    before { @appointment.appointment_type = 'checkup' }

    it { expect(@appointment).to be_valid }
  end
end
