class AddCreatedByToTables < ActiveRecord::Migration
  def self.up
    add_column :binary_assets, :created_by_id, :integer
    add_column :binary_assets, :updated_by_id, :integer
    
    add_column :sites, :created_by_id, :integer
    add_column :sites, :updated_by_id, :integer

    add_column :textual_assets, :created_by_id, :integer
    add_column :textual_assets, :updated_by_id, :integer

    add_column :users, :created_by_id, :integer
    add_column :users, :updated_by_id, :integer
  end

  def self.down
    remove_column :binary_assets, :created_by_id
    remove_column :binary_assets, :updated_by_id
    
    remove_column :sites, :created_by_id
    remove_column :sites, :updated_by_id
    
    remove_column :textual_assets, :created_by_id
    remove_column :textual_assets, :updated_by_id
    
    remove_column :users, :created_by_id
    remove_column :users, :updated_by_id
  end
end
