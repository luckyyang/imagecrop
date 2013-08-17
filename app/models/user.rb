class User < ActiveRecord::Base
  attr_accessible :name, :avatar
  attr_accessible :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_avatar, :if => :cropping?

  has_attached_file :avatar, :styles => {:large => "500x500>", :normal => "300x300>", :small => "200x200>",  :thumb => "100x100>" }, :default_url => "/images/:style/missing.png",
  :processors => [:cropper],
  :url  => "/assets/users/:id/:style/:basename.:extension",
  :path => ":rails_root/app/assets/images/users/:id/:style/:basename.:extension"

  validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']

    def cropping?
      !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
    end

    def avatar_geometry(style = :original)
      @geometry ||= {}
      @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
    end

    private

    def reprocess_avatar
      avatar.assign(avatar)
      avatar.save
    end
end
