class CreateMeetings < ActiveRecord::Migration[5.0]
  def change
    create_table :meetings do |t|
      t.integer :inviter_id
      t.string :subject
      t.string :location
      t.datetime :start_time
      t.datetime :end_time
      t.integer :max_size

      t.timestamps
    end
  end
end
