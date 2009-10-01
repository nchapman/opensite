class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :name,         :null => false
      t.string :description
      t.string :subdomain,    :null => false
      t.timestamps
      
      t.index :subdomain
    end
  end

  def self.down
    drop_table :sites
  end
end
