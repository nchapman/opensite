class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.belongs_to :site
      t.string :title
      t.string :slug
      t.timestamps
    end
    
    add_index :pages, :site_id
    add_index :pages, [:site_id, :slug]
  end

  def self.down
    drop_table :pages
  end
end
