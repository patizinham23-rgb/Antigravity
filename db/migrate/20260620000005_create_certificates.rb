class CreateCertificates < ActiveRecord::Migration[8.0]
  def change
    create_table :certificates do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :enrollment, null: false, foreign_key: true
      t.string :code, null: false
      t.datetime :issued_at, null: false, default: -> { "CURRENT_TIMESTAMP" }

      t.timestamps
    end

    add_index :certificates, :code, unique: true
    add_index :certificates, [:user_id, :course_id], unique: true
  end
end
