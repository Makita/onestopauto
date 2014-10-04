require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AppointmentHelper. For example:
#
# describe AppointmentHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AppointmentHelper, :type => :helper do
  describe '#value_format' do
    context 'when name == phone_number' do
        it { expect(helper.value_format('phone_number', '3607201337')).to eq(number_to_phone('3607201337', area_code: true)) }
    end

    context 'when name == appointment_type' do
      it { expect(helper.value_format('appointment_type', 'checkup')).to eq('Check-up') }
      it { expect(helper.value_format('appointment_type', 'repair')).to eq('Repair') }
    end

    before { @appointment = build(:appointment) }

    context 'when name == date' do
      it { expect(helper.value_format('date', @appointment.date)).to eq(@appointment.date.strftime('%B %-d, %Y')) }
    end

    context 'when name == time' do
      it { expect(helper.value_format('time', @appointment.time)).to eq(@appointment.time.strftime('%H:%M')) }
    end
  end
end
