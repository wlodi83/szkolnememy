class AddCategoryToMemes < ActiveRecord::Migration
  def change
    add_column :memes, :category_id, :int
  end
end
