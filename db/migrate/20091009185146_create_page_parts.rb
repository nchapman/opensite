class CreatePageParts < ActiveRecord::Migration
  def self.up
    create_table :page_parts do |t|
      t.belongs_to :page
      t.string :name
      t.text :content
      t.timestamps
    end
    
    add_index :page_parts, :page_id
    add_index :page_parts, [:page_id, :name]
  end

  def self.down
    drop_table :page_parts
  end
end
