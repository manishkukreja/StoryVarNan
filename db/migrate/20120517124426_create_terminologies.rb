class CreateTerminologies < ActiveRecord::Migration
  def self.up
    create_table :terminologies do |t|
      t.integer :book_id
      t.integer :language_id

      t.timestamps
    end
  end

  def self.down
    drop_table :terminologies
  end
end
