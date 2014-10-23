class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :cohort_id
      t.string :name
      t.string :email
      t.string :github
    end

    add_index :students, :cohort_id
    add_index :students, :email, :unique => true
    add_index :students, :github, :unique => true
  end
end
