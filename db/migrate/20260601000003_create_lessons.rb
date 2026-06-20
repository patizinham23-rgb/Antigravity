class CreateLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons do |t|
      t.references :course, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content
      t.string :video_url
      t.integer :duration, default: 0
      t.integer :position, default: 0, null: false
      t.boolean :free_preview, default: false

      t.timestamps
    end

    add_index :lessons, [:course_id, :position]
  end
end
