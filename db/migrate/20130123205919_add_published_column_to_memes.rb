class AddPublishedColumnToMemes < ActiveRecord::Migration
  def change
    add_column :memes, :published, :boolean, :default => false
  end
end
