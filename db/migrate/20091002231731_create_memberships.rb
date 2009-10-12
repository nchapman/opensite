class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.belongs_to :site
      t.belongs_to :user
      t.timestamps
      t.index [:user, :site]
    end
  end

  def self.down
    drop_table :memberships
  end
end
