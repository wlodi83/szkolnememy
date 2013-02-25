class CreateDialogs < ActiveRecord::Migration
  def change
    create_table :dialogs do |t|
      t.string :message
      t.string :link
      t.string :name
      t.string :caption
      t.text :description

      t.timestamps
    end
  end
end
