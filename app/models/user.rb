class User < ApplicationRecord
    before_save { self.email.downcase! }
    
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    #validates :bscore , length: {maximum: 3}
    #validates :distance , length: {maximum: 3}
    #validates :image 
    #validates :address , length: {maximum: 50}
    #validates :hcourse , length: {maximum: 50}
    #validates :bplace , length: {maximum: 50}
    
      has_many :messages
    #has_many :sent_messages, through: :messages, source: :receiver_id
    
    has_many :reverses_of_message , class_name: :Message , foreign_key: :receiver_id
    #has_many :received_messages, through: :reverses_of_message, source: :user
    
    
    has_secure_password
    mount_uploader :image, ImageUploader
end
