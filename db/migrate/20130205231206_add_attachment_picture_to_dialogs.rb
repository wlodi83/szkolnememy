class AddAttachmentPictureToDialogs < ActiveRecord::Migration
  def self.up
    change_table :dialogs do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :dialogs, :picture
  end
end
