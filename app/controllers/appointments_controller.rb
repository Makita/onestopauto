class AppointmentsController < ApplicationController
  before_filter :set_type

  def new
    @appointment = Appointment.new
  end

  def confirm
    @appointment = Appointment.new(appointment_params)

    if @appointment.invalid?
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
    @confirmation_details[:billing_address]  = @appointment.billing_address
    @confirmation_details[:billing_phone]    = @appointment.billing_phone
  end
  
  private

  def set_type
    unless params[:type].blank? and params[:appointment].blank?
      @type = params[:type] || appointment_params[:appointment_type]
    end
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_type, :first_name, :last_name, :vehicle_make, :vehicle_year, :vehicle_issue, :billing_address, :billing_phone)
  end
end
