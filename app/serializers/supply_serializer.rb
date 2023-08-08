class SupplySerializer < ActiveModel::Serializer
  attributes :id, :country, :assign_to, :boxmark, :type_flower, :variety, :s1, :quantity, :boxtype, :stems, :cost, :amount, :total, :supplier_id
  belongs_to :supplier, optional: true

end
