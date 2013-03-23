class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :votable_id, null: false
      t.string :votable_type, null: false
      t.integer :rating, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index "votes", ["votable_id", "votable_type", "user_id"], :name => "index_votes_on_votable_user", :unique => true
  end
end
