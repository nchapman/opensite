class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :name,         :null => false
      t.string :description
      t.string :subdomain,    :null => false
      t.timestamps
    end
    
    add_index :sites, :subdomain
  end

  def self.down
    drop_table :sites
  end
end
