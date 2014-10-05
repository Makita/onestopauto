class AdminController < ApplicationController
  before_action :authenticate_admin!, except: [:sign_in, :authenticate]

  def sign_in
    @admin = Admin.new
  end

  def authenticate
    @admin = Admin.find_by_username(params[:admin][:username])
    if @admin.nil? or @admin.password != params[:admin][:password_hash]
      @admin = Admin.new
      flash[:error] = 'Incorrect username or password.'
      render :sign_in
    else
      session[:user_id] = @admin.id
      redirect_to admin_path
    end
  end

  def sign_out
    session.delete(:user_id)
    redirect_to request.referrer
  end

  def appointments
    @appointments = Appointment.all.order(:date, :time)
  end

  private

  def authenticate_admin!
    redirect_to sign_in_path if current_admin.nil?
  end
end
