class Message < ApplicationRecord
  
  validates :content, presence: true, length: { maximum: 255 }
  
  belongs_to :user
  belongs_to :receiver , class_name: "User"
  
   mount_uploader :image, ImageUploader
  
end
