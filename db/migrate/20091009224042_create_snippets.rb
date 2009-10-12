class CreateSnippets < ActiveRecord::Migration
  def self.up
    create_table :snippets do |t|
      t.belongs_to :site
      t.string :name
      t.text :content
      t.timestamps
    end
    
    add_index :snippets, :site_id
    add_index :snippets, [:site_id, :name]
  end

  def self.down
    drop_table :snippets
  end
end
