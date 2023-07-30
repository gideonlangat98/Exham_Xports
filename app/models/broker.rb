class Broker < ApplicationRecord
    require "securerandom"
    has_secure_password

    has_many :buyers
    has_many :suppliers
end
