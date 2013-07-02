class CreateAgeGroups < ActiveRecord::Migration
  def change
    create_table :age_groups do |t|
      t.string :age_range
      t.string :display_grade

      t.timestamps
    end
  end
end
