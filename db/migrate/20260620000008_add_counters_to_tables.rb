class AddCountersToTables < ActiveRecord::Migration[8.0]
  def change
    add_column :discussion_threads, :discussion_replies_count, :integer, default: 0, null: false

    add_column :courses, :average_rating, :decimal, precision: 2, scale: 1, default: 0.0
    add_column :courses, :reviews_count, :integer, default: 0, null: false
  end
end
