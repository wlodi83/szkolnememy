class Video < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  scope :published, where(:published => true).order("created_at DESC").limit(250)
  scope :not_published, where(:published => false)
  scope :filter_by_category, lambda {|category| where("category_id = ? and published = ?", category, true).limit(250)}
  attr_accessible :title, :description, :published, :link, :category_id
  belongs_to :category
  def youtube_id
    self.link.match(/(?<=[?&]v=)[^&$]+/)[0] if self.link
  end  
end
