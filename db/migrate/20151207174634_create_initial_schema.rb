class CreateInitialSchema < ActiveRecord::Migration
  def change
    create_table :users do |table|
      table.string :provider, null: false
      table.string :uid, null: false
      table.string :username, null: false
      table.string :email, null: false
      table.string :avatar_url, null: false

      table.timestamps null: false
    end

    add_index :users, [:uid, :provider], unique: true

    create_table :meetups do |t|
      t.belongs_to :user, index: true
      t.string :name, null: false
      t.string :description, null: false
      t.datetime :start, null: false
      t.datetime :end, null: false

      t.timestamps null: false
    end

    create_table :users_meetups do |t|
      t.belongs_to :user, index: true
      t.belongs_to :meetup, index: true

      t.timestamps null: false
    end

    create_table :comments do |t|
      t.string :body, null: false
      t.belongs_to :user, index: true
      t.belongs_to :meetup, index: true

      t.timestamps null: false
    end
  end
end
