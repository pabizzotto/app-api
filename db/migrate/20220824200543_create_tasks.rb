class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.datetime :register_at, null: false, default: DateTime.now
      t.datetime :concluded_at
      t.integer :duration, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.text :description
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
