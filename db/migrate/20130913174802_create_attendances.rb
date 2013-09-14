class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :user, index: true
      t.date :working_day, null: false
      t.integer :working_time, null: false
      t.text :comment

      t.timestamps
    end
    add_index :attendances, [:working_day, :user_id], unique: true
  end
end
