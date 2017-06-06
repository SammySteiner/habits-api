class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.text :description
      t.boolean :repeat
      t.boolean :complete, :default => false
      t.datetime :completed_at
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
