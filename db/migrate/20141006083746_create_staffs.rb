class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.attachment :image
      t.string :name
      t.string :position
      t.text :description

      t.timestamps
    end
  end
end
