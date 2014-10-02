class AppointmentsController < ApplicationController
  before_filter :set_type

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to appointment_path(@appointment)
    else
      render :new
    end
  end

  def show
    @appointment = Appointment.find(params[:id])

    @confirmation_details = HashWithIndifferentAccess.new
    @confirmation_details[:first_name]      = @appointment.first_name
    @confirmation_details[:last_name]       = @appointment.last_name
    @confirmation_details[:vehicle_make]    = @appointment.vehicle_make
    @confirmation_details[:vehicle_year]    = @appointment.vehicle_year
    @confirmation_details[:vehicle_issue]   = @appointment.vehicle_issue
    @confirmation_details[:billing_address] = @appointment.billing_address
    @confirmation_details[:billing_phone]   = @appointment.billing_phone
    @confirmation_details[:card_number]     = @appointment.card_number
    @confirmation_details[:cardholder_name] = @appointment.cardholder_name
  end
  
  private

  def set_type
    unless params[:type].blank? and params[:appointment].blank?
      @type = params[:type] || appointment_params[:type]
    end
  end

  def appointment_params
    params.require(:appointment).permit(:type, :first_name, :last_name, :vehicle_make, :vehicle_year, :vehicle_issue, :billing_address, :billing_phone, :card_number, :csc, :cardholder_name)
  end
end
