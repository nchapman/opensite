class AddCreatedByAndUpdatedByToTemplates < ActiveRecord::Migration
  def self.up
    add_column :templates, :created_by_id, :integer
    add_column :templates, :updated_by_id, :integer
  end

  def self.down
    remove_column :templates, :updated_by_id
    remove_column :templates, :created_by_id
  end
end
