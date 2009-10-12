class AddHomeToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :home, :boolean
    add_index :pages, [:site_id, :home]
  end

  def self.down
    remove_column :pages, :home
  end
end
