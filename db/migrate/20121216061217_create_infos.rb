class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|

      t.timestamps
    end
  end
end
