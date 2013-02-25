class AddColumnToMemes < ActiveRecord::Migration
  def change
    add_column :memes, :slug, :string
    add_index :memes, :slug, unique: true
  end
end
