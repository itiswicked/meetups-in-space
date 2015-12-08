class DropStartEndMeetups < ActiveRecord::Migration
  def change
    remove_column :meetups, :start
    remove_column :meetups, :end
  end
end
