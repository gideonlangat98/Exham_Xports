class BuyerFoamSerializer < ActiveModel::Serializer
  attributes :id, :supplier_name, :country, :boxMark, :variety, :s1, :stems, :quantity, :boxtype, :cost, :amount, :price, :total, :duty, :assigned_to, :buyer_id
  belongs_to :buyer, optional: true
end
