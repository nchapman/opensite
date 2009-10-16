class AddTemplateIdToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :template_id, :integer
    add_index :pages, [:template_id]
  end

  def self.down
    remove_index :pages, [:template_id]
    remove_column :pages, :template_id 
  end
end
