class CreateUserInvitees < ActiveRecord::Migration
  def change
    create_table :user_invitees do |t|
      t.integer :user_id
      t.string :friend_name
      t.string :friend_email
      t.date :invitation_date
      t.string :invitation_status

      t.timestamps
    end
  end
end
