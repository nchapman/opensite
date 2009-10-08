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
      
      t.index [:site_id, :type, :slug]
    end
  end

  def self.down
    drop_table :binary_assets
  end
end
