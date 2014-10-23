class CreateGroupings < ActiveRecord::Migration
  def change
    create_table :groupings do |t|
      t.integer :cohort_id
    end

    add_index :groupings, :cohort_id
  end
end
