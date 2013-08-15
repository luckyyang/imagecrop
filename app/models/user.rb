class User < ActiveRecord::Base
  attr_accessible :name, :avatar
  has_attached_file :avatar, :styles => { :normal => "300x300>", :small => "200x200>",  :thumb => "100x100>" }, :default_url => "/images/:style/missing.png",
  :url  => "/assets/users/:id/:style/:basename.:extension",
  :path => ":rails_root/public/assets/users/:id/:style/:basename.:extension"
end
