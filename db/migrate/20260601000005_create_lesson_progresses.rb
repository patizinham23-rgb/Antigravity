class CreateLessonProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :lesson_progresses do |t|
      t.references :enrollment, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.boolean :completed, default: false
      t.datetime :completed_at

      t.timestamps
    end

    add_index :lesson_progresses, [:enrollment_id, :lesson_id], unique: true
  end
end
