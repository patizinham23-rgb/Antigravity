class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.integer :rating, null: false, default: 5
      t.text :comment

      t.timestamps
    end

    add_index :reviews, [:user_id, :course_id], unique: true
  end
end
