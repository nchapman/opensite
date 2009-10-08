class CreateTextualAssets < ActiveRecord::Migration
  def self.up
    create_table :textual_assets do |t|
      t.string :name
      t.belongs_to :site
      t.string :type
      t.string :content_type
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :textual_assets
  end
end
