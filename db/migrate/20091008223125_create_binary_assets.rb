class CreateBinaryAssets < ActiveRecord::Migration
  def self.up
    create_table :binary_assets do |t|
      t.belongs_to :site
      t.string :name
      t.string :type
      t.string :slug
      t.string :asset_file_name
      t.string :asset_content_type
      t.integer :asset_file_size
      t.datetime :asset_updated_at
      t.timestamps
    end
    
    add_index :binary_assets, :site_id
    add_index :binary_assets, [:site_id, :slug]
  end

  def self.down
    drop_table :binary_assets
  end
end
