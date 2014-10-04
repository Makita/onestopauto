require 'rails_helper'

RSpec.describe AppointmentsController, :type => :controller do
  describe 'GET new' do
    it 'renders the new template' do
      get :new, type: 'repair'
      expect(response).to render_template(:new)
    end
  end

  describe 'POST confirm' do
    it 'renders the new template if appointment is invalid' do
      post :confirm, appointment: Appointment.new.attributes
      expect(response).to render_template(:new)
    end

    before { @appointment = build(:appointment) }

    it 'renders the confirm template if appointment is valid' do
      post :confirm, appointment: @appointment.attributes
      expect(response).to render_template(:confirm)
    end
  end
end
