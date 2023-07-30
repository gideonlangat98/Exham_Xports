class BrokerSerializer < ActiveModel::Serializer
  
  attributes :id, :first_name,:last_name ,:email, :password_digest, :isBroker
  has_many :buyers
  has_many :suppliers
end
