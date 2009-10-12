class CreatePageParts < ActiveRecord::Migration
  def self.up
    create_table :page_parts do |t|
      t.belongs_to :page
      t.string :name
      t.text :content
      t.timestamps
      t.index :page_id
      t.index [:page_id, :name]
    end
  end

  def self.down
    drop_table :page_parts
  end
end
