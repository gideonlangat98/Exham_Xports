class BuyerSerializer < ActiveModel::Serializer
    attributes :id, :buyer_name,:email, :password_digest, :isBuyer,:broker_id
    belongs_to :broker, optional: true
  end
  