class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :link
      t.boolean :published

      t.timestamps
    end
  end
end
