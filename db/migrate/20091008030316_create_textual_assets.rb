class CreateTextualAssets < ActiveRecord::Migration
  def self.up
    create_table :textual_assets do |t|
      t.string :name
      t.belongs_to :site
      t.string :type
      t.string :content_type
      t.string :slug
      t.text :content
      t.timestamps
      t.index :site_id
      t.index [:site_id, :slug]
    end
    
    add_index :textual_assets, :site_id
    add_index :textual_assets, [:site_id, :slug]
  end

  def self.down
    drop_table :textual_assets
  end
end
