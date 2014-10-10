class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string :slug
      t.string :name
    end

    add_index :cohorts, :slug, :unique => true
  end
end
