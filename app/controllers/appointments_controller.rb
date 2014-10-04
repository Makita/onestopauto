class AppointmentsController < ApplicationController
  before_filter :set_type

  def new
    @appointment = Appointment.new
  end

  def confirm
    @appointment = Appointment.new(appointment_params)

    if @appointment.invalid?
      flash[:error] = 'Failed to create appointment.'
      render :new
      return
    end

    @attributes = @appointment.attributes.except('id', 'created_at', 'updated_at')
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @customer = Stripe::Customer.create(email: params[:stripeEmail], card: params[:stripeToken])
    @charge = Stripe::Charge.create(customer: @customer.id, amount: 500, description: 'Appointment Confirmation Payment', currency: 'cad')

    if @appointment.save
      redirect_to appointment_path(@appointment)
    else
      @attributes = @appointment.attributes.except('id', 'created_at', 'updated_at')
      raise StandardError
      render :confirm
    end

  rescue Stripe::CardError => e
    @attributes = @appointment.attributes.except('id', 'created_at', 'updated_at')
    flash[:error] = e.message
    render :confirm
  end

  def show
    @appointment = Appointment.find(params[:id])

    @confirmation_details = HashWithIndifferentAccess.new
    @confirmation_details[:appointment_type] = @appointment.appointment_type
    @confirmation_details[:first_name]       = @appointment.first_name
    @confirmation_details[:last_name]        = @appointment.last_name
    @confirmation_details[:vehicle_make]     = @appointment.vehicle_make
    @confirmation_details[:vehicle_year]     = @appointment.vehicle_year
    @confirmation_details[:vehicle_issue]    = @appointment.vehicle_issue
    @confirmation_details[:address]          = @appointment.address
    @confirmation_details[:phone_number]     = @appointment.phone_number
    @confirmation_details[:date]             = @appointment.date
    @confirmation_details[:time]             = @appointment.time
  end

  def check_appointment_hours
    get_appointment_times

    @appointment_times.each { |time| @result << time.hour }

    # Check if hours are completely filled so we don't check in the javascript
    @result = @result.group_by { |x| x }.select { |k, v| v.size > 1 }.map(&:first)

    render json: @result.to_json
  end

  def check_appointment_minutes
    get_appointment_times

    @appointment_times.each { |time| @result << time.min if time.hour == params[:hour].to_i }

    render json: @result.to_json
  end
  
  private

  def set_type
    unless params[:type].blank? and params[:appointment].blank?
      @type = params[:type] || appointment_params[:appointment_type]
    end
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_type, :first_name, :last_name, :vehicle_make, :vehicle_year, :vehicle_issue, :address, :phone_number, :date, :time)
  end

  def get_appointment_times
    @appointment_times = Appointment.where(date: Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)).map { |x| x.time }
    @result = Array.new
  end
end
