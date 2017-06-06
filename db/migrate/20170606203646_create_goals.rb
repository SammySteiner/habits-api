class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.string :title
      t.text :description
      t.boolean :complete, :default => false
      t.datetime :completed_at
      t.datetime :expiration
      t.belongs_to :plan, foreign_key: true

      t.timestamps
    end
  end
end
