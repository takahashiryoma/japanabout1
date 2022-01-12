class Prefecture < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    
    has_many :wants
    accepts_nested_attributes_for :wants
     
end
