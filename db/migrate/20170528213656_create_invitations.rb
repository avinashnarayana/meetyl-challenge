class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.references :meeting, foreign_key: true
      t.integer :invitee_id
      t.string :response

      t.timestamps
    end
    add_index :invitations, [:meeting_id, :invitee_id], unique: true
  end
end
