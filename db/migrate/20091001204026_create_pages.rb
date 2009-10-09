class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.belongs_to :site
      t.string :title
      t.string :slug
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
