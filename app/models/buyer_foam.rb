class BuyerFoam < ApplicationRecord
    belongs_to :buyer, optional: true
end
