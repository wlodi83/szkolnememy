class AddFieldsToMemes < ActiveRecord::Migration
  def change
    add_column :memes, :title, :string
    add_column :memes, :description, :text
  end
end
