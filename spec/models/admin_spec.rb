require 'rails_helper'
require 'spec_helper'

RSpec.describe Admin, :type => :model do
  before { @admin = Admin.new(password: 'password') }

  subject { @admin }

  it {
    should validate_presence_of :username
    should respond_to :password
  }

  context "when username is empty" do
    it { should_not be_valid }
    specify { expect(@admin.save).to be == false }
  end

  context "when username and password are filled" do
    before { @admin.username = 'admin' }

    it { should be_valid }
    specify { expect(@admin.save).to be == true }
  end
end
