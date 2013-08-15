class User < ActiveRecord::Base
  attr_accessible :name, :avatar
  has_attached_file :avatar, :styles => { :normal => "300x300>", :small => "200x200>",  :thumb => "100x100>" }, :default_url => "/images/:style/missing.png",
  :url  => "/assets/users/:id/:style/:basename.:extension",
  :path => ":rails_root/public/assets/users/:id/:style/:basename.:extension"

  validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']
end
