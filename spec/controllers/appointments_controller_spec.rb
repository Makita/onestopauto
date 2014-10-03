require 'rails_helper'

RSpec.describe AppointmentsController, :type => :controller do
  describe 'GET new' do
    it 'renders the new template' do
      get :new, type: 'repair'
      expect(response.status).to render_template(:new)
    end
  end

  describe 'GET new' do
    it 'does something'
  end
end
