FactoryGirl.define do
  factory :appointment do
    appointment_type 'repair'
    first_name 'First'
    last_name 'Last'
    vehicle_make 'Make'
    vehicle_year '1984'
    vehicle_issue 'Lotsa shiet.'
    address 'Aperture Science Testing Facility, Ltd.'
    phone_number '9119119111'
    date Date.new(2015, 1, 2)
    time Time.utc(2015, 1, 2, 12, 0)
  end
end
