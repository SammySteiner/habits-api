class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.boolean :complete, :default => false
      t.datetime :completed_at
      t.integer :interval
      t.belongs_to :plan, foreign_key: true

      t.timestamps
    end
  end
end
