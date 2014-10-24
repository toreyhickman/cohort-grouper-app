class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :grouping_id
    end

    add_index :groups, :grouping_id
  end
end
