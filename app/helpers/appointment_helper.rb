module AppointmentHelper
  def value_format(name, value)
    return "XXXX-XXXX-XXXX-#{ value.slice(-4..-1) }" if name == 'card_number'
    return number_to_phone(value, area_code: true) if name == 'billing_phone'
    if name == 'appointment_type'
      return 'Check-up' if value == 'checkup'
      return 'Repair'
    end
    value
  end
end
