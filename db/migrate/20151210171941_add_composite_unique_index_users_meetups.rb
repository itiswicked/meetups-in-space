class AddCompositeUniqueIndexUsersMeetups < ActiveRecord::Migration
  def up
    add_index :users_meetups, [:meetup_id, :user_id], unique: true

    remove_index :users_meetups, :meetup_id
    remove_index :users_meetups, :user_id
  end

  def down
    remove_index :users_meetups, [:meetup_id, :user_id]

    add_index :users_meetups, :meetup_id
    add_index :users_meetups, :user_id
  end
end
