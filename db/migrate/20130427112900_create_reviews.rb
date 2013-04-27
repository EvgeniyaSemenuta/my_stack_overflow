class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :question_id, null: false

      t.timestamps
    end

    add_index :reviews, [:user_id, :question_id], unique: true
  end
end
