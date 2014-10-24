class CreateGroupParticipations < ActiveRecord::Migration
  def change
    create_table :group_participations do |t|
      t.integer :student_id
      t.integer :group_id
    end

    add_index :group_participations, :student_id
    add_index :group_participations, :group_id
  end
end
