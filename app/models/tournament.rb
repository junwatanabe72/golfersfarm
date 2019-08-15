class Tournament < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 50 }
  validates :rank , length: {maximum: 10}
  validates :year , length: {maximum: 4}
  
  
  
end
