class Buyer < ApplicationRecord
    require "securerandom"
    has_secure_password

    belongs_to :broker, optional: true

    has_many :buyer_foams

    # validates :buyer_name, presence: true
    
end
