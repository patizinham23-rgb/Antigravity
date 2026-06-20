class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.text :description
      t.string :short_description
      t.decimal :price, precision: 10, scale: 2, null: false, default: 0
      t.integer :status, default: 0, null: false
      t.references :instructor, null: false, foreign_key: { to_table: :users }
      t.string :category
      t.string :image
      t.integer :duration, default: 0
      t.integer :level, default: 0

      t.timestamps
    end

    add_index :courses, :status
    add_index :courses, :category
  end
end
