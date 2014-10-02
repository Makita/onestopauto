class RemoveCreditCardDetailsFromAppointments < ActiveRecord::Migration
  def change
    remove_column :appointments, :card_number
    remove_column :appointments, :csc
    remove_column :appointments, :cardholder_name
  end
end
