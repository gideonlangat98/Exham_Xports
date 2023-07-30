class SupplierSerializer < ActiveModel::Serializer
  
    attributes :id, :supplier_name,:email, :password_digest, :isSupplier,:broker_id
    belongs_to :broker
  end