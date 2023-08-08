class SessionsController < ApplicationController
  # skip_before_action :authenticate_admin, only: [:create]

  def create
    buyer = Buyer.find_by_email(params[:email])
    broker = Broker.find_by_email(params[:email])
    supplier = Supplier.find_by_email(params[:email])

    if buyer&.authenticate(params[:password])
      token = jwt_encode(buyer_id: buyer.id)
      render json: { token: token, isBuyer: true, buyer_name: buyer.buyer_name }, status: :ok
    elsif broker&.authenticate(params[:password])
      token = jwt_encode(broker_id: broker.id)
      render json: { token: token, isBroker: true }, status: :ok
    elsif supplier&.authenticate(params[:password])
      token = jwt_encode(supplier_id: supplier.id)  # Fixed typo: "supplier", not "suplier"
      render json: { token: token, isSupplier: true, supplier_name: supplier.supplier_name }, status: :ok
    else
      render json: { errors: 'Invalid Password or email' }, status: :unauthorized
    end
  end

  def destroy
    # Token-based authentication doesn't require session deletion
    head :no_content
  end
end
