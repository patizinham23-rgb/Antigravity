class CreateDiscussionThreads < ActiveRecord::Migration[8.0]
  def change
    create_table :discussion_threads do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :lesson, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :pinned, default: false

      t.timestamps
    end

    add_index :discussion_threads, [:course_id, :pinned]
  end
end
