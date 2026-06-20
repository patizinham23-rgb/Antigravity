class AddCategoryToCourses < ActiveRecord::Migration[8.0]
  def change
    remove_column :courses, :category, :string
    add_reference :courses, :category, foreign_key: true
  end
end
