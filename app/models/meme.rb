class Meme < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  scope :published, where(:published => true).order("created_at DESC").limit(250)
  scope :not_published, where(:published => false)
  scope :filter_by_category, lambda {|category| where("category_id = ? and published = ?", category, true).limit(250)}
  attr_accessible :title, :description, :image, :published, :category_id
  belongs_to :category
  has_attached_file :image,
    :styles => {
      :preview => "380x200^",
      :medium => "320x200^",
      :thumb => "100x100^" },
    :convert_options => {
      :preview => Proc.new{ |meme| self.convert_options(meme.title, meme.description, "380", "60", "15", "30", "15", "20", "15") },
      :medium => Proc.new{ |meme| self.convert_options(meme.title, meme.description, "320", "30", "10", "15", "10", "10", "5")},
      :thumb => Proc.new{ |meme| self.convert_options(meme.title, meme.description, "100", "15", "5", "1", "5", "5", "1")}
    },
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "images/memes/:style/:filename"
  validates :title, :length => { :minimum => 1 }
  validates :title, :length => { :maximum => 50 }
  validates :description, :length => { :minimum => 1 }
  validates :description, :length => { :maximum => 100 }
  validates_attachment :image, :presence => true,
    :content_type => { :content_type => ['image/jpeg', 'image/jpg', 'image/png'] },
    :size => { :in => 0..1000.kilobytes }
  def self.convert_options(title, description, width, height, pointsize, labelsize, frame, captionsize, captionsize_2)
    trans = ""
    trans << "-background white -fill black -font Times-Bold -pointsize #{pointsize} -gravity center -size x#{labelsize} label:'SZKOLNEMEMY.PL' -append -mattecolor black -frame #{frame}x#{frame} -background black -fill yellow -font Times-Bold -pointsize #{captionsize} -size #{width}x#{height} -gravity center caption:\"#{title}\" -append -background black -fill white -font Times-Bold -pointsize #{captionsize_2} -size #{width}x#{height} -gravity center caption:\"#{description}\" -append"
  end
end
