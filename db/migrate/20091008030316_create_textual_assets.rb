class CreateTextualAssets < ActiveRecord::Migration
  def self.up
    create_table :textual_assets do |t|
      t.string :name
      t.belongs_to :site
      t.string :type
      t.string :content_type
      t.string :slug
      t.text :body
      t.timestamps
      
      t.index [:site_id, :type, :slug]
    end
  end

  def self.down
    drop_table :textual_assets
  end
end
