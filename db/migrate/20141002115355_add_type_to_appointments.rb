class AddTypeToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :type, :string
  end
end
