class User < ApplicationRecord
  
    before_save { self.email.downcase! }
    before_create :create_activation_digest

    enum status:{open: 0 , closed: 1}
    enum sex:{男性: 0 , 女性: 1}
    
    #要素
    
    attr_accessor :remember_token,  :activation_token, :reset_token
   
   #バリテーション
    
    validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    validates :bscore , length: {maximum: 3}
    validates :distance , length: {maximum: 3}
    #validates :image 
    validates :address , length: {maximum: 50}
    validates :hcourse , length: {maximum: 50}
    validates :bplace , length: {maximum: 50}
    validates :hobby , length: {maximum: 50}
    validates :job , length: {maximum: 50}
    validates :school , length: {maximum: 50}
    validates :driver , length: {maximum: 50}
    validates :dshaft , length: {maximum: 50}
    validates :wood , length: {maximum: 50}
    validates :ut , length: {maximum: 50}
    validates :iron , length: {maximum: 50}
    validates :wedge , length: {maximum: 50}  
    validates :putter , length: {maximum: 50}
    
    has_many :messages ,dependent: :destroy
    #has_many :sent_messages, through: :messages, source: :receiver_id
    has_many :reverses_of_message , class_name: :Message , foreign_key: :receiver_id ,dependent: :destroy
    #has_many :received_messages, through: :reverses_of_message, source: :user
    
    has_many :tournaments ,dependent: :destroy

    has_secure_password
    
    mount_uploader :image, ImageUploader
    mount_uploader :gear, ImageUploader
    
    #フォロー機能
    
    has_many :relationships ,dependent: :destroy
    has_many :followings, through: :relationships, source: :follow ,dependent: :destroy
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id' ,dependent: :destroy
    has_many :followers, through: :reverses_of_relationship, source: :user ,dependent: :destroy
    
    def follow(other_user)
      unless self == other_user
        self.relationships.find_or_create_by(follow_id: other_user.id)
      end
    end

    def unfollow(other_user)
      relationship = self.relationships.find_by(follow_id: other_user.id)
      relationship.destroy if relationship
    end

    def following?(other_user)
      self.followings.include?(other_user)
    end
    
    #メソッド
    
    
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
    
 #永続的セッション  
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
    
  def forget
    update_attribute(:remember_digest, nil)
  end
    
 #永続的セッション＋メール認証
  
  def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
  end
    
  
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  #パスワード再設定
  
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
    
  
end
