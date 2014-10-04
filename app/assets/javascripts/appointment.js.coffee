# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
changeAvailableHours = () ->
  $.ajax
    url: "/check_appointment_hours"
    data:
      year: $('#appointment_date_1i').val()
      month: $('#appointment_date_2i').val()
      day: $('#appointment_date_3i').val()
    success: (result) =>
      $('#appointment_time_4i').empty()
      for i in [8..18]
        if result.indexOf(i) == -1
          option = $('<option></option>').attr('value', pad(i)).text(pad(i))
          $('#appointment_time_4i').append(option)

changeAvailableMinutes = () ->
  $.ajax
    url: "/check_appointment_minutes"
    data:
      year: $('#appointment_date_1i').val()
      month: $('#appointment_date_2i').val()
      day: $('#appointment_date_3i').val()
      hour: $('#appointment_time_4i').val()
    success: (result) =>
      $('#appointment_time_5i').empty()
      for i in [0,30]
        if result.indexOf(i) == -1
          option = $('<option></option>').attr('value', pad(i)).text(pad(i))
          $('#appointment_time_5i').append(option)

$ ->
  $('#appointment_date_1i').change(changeAvailableHours)
  $('#appointment_date_2i').change(changeAvailableHours)
  $('#appointment_date_3i').change(changeAvailableHours)

  $('#appointment_time_4i').change(changeAvailableMinutes)
