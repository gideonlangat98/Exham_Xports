class Supplier < ApplicationRecord
    require "securerandom"
    has_secure_password
    
    belongs_to :broker, optional: true

    has_many :supplies
    
    # validates :supplier_name, presence: true
end
