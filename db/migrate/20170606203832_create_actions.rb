class CreateActions < ActiveRecord::Migration[5.0]
  def change
    create_table :actions do |t|
      t.text :description
      t.boolean :complete, :default => false
      t.datetime :completed_at
      t.belongs_to :goal, foreign_key: true

      t.timestamps
    end
  end
end
