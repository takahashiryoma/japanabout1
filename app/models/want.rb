class Want < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture, optional: true
  has_many :favorites, dependent: :destroy
  
  validates :content, presence: true, length: { maximum: 255 }
  

end
