class CreatePageParts < ActiveRecord::Migration
  def self.up
    create_table :page_parts do |t|
      t.belongs_to :page
      t.string :name
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :page_parts
  end
end
