class RouteProfile < ActiveRecord::Base
  mount_uploader :image, RouteImageUploader
  mount_uploader :icon, RouteIconUploader
  attr_accessible :description_en, :description_nl, :icon, :image, :name_en, :name_nl
  has_many :routes
  def image_data
    Base64.encode64(open(self.image.to_s) { |io| io.read }) unless self.image.to_s.blank?
  end
  def icon_data
    Base64.encode64(open(self.icon.to_s) { |io| io.read }) unless self.icon.to_s.blank?
  end
end