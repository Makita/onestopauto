class AppointmentController < ApplicationController
  before_filter :set_type

  def new
  end
  
  def set_type
    @type = params[:type]
  end
end
