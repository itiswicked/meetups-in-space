class AddColumnLocationToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :location, :string
  end
end
