module AppointmentHelper
  def value_format(name, value)
    return number_to_phone(value, area_code: true) if name == 'phone_number'
    if name == 'appointment_type'
      return 'Check-up' if value == 'checkup'
      return 'Repair'
    end
    return value.strftime('%B %-d, %Y') if name == 'date'
    return value.strftime('%H:%M') if name == 'time'
    value
  end
end
