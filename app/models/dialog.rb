class Dialog < ActiveRecord::Base
  attr_accessible :caption, :description, :link, :message, :name, :picture
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "images/dialogs/:id/:style/:filename"
  validates_attachment :picture, :presence => true,
    :content_type => { :content_type => ['image/jpeg', 'image/jpg', 'image/png'] },
    :size => { :in => 0..1000.kilobytes }
end
