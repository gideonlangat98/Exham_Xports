class SupplySerializer < ActiveModel::Serializer
  attributes :id, :country, :boxmark, :type_flower, :variety, :s1, :quantity, :boxtype, :stems, :cost, :amount, :total,:supplier_id
  belongs_to :supplier
end
