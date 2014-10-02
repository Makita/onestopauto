class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :first_name
      t.string :last_name

      t.string :vehicle_make
      t.integer :vehicle_year
      t.text :vehicle_issue

      t.string :billing_address
      t.string :billing_phone
      t.string :card_number
      t.string :csc
      t.string :cardholder_name

      t.timestamps
    end
  end
end
