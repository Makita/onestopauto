class ChangeBillingFieldNames < ActiveRecord::Migration
  def change
    rename_column :appointments, :billing_address, :address
    rename_column :appointments, :billing_phone, :phone_number
  end
end
