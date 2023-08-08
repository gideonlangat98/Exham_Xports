class BuyerFoamsController < ApplicationController
  before_action :authenticate_buyer, only: [:index, :show, :update]
  before_action :deny_buyer, only: [:show, :update, :destroy]
  before_action :deny_access, only: [:show, :update, :destroy]
  
  def index
    if current_broker
      buyer_foams = BuyerFoam.all
    else
      buyer_foams = BuyerFoam.where(assigned_to: @current_buyer.buyer_name)
    end

    render json: buyer_foams, status: :ok
  end

  # GET /buyer_foams/1
  def show
    buyer_foam = BuyerFoam.find_by(id: params[:id])
    if buyer_foam
      if current_broker || buyer_foam.buyer_id == @current_buyer.id
        render json: buyer_foam
      else
        render_unauthorized
      end
    else
      render json: { error: "BuyerFoam not found" }, status: :not_found
    end
  end

  def create
    buyer_name = params[:buyer_name]
      @current_buyer = Buyer.find_by(buyer_name: buyer_name)

      if @current_buyer.nil?
        render json: { error: "Buyer not found with name '#{buyer_name}'" }, status: :unprocessable_entity
        return
      end

     buyer_foam = BuyerFoam.new(buyer_foam_params)
     buyer_foam.buyer_id = @current_buyer.id
  
    if buyer_foam.save
      render json: buyer_foam, status: :created
    else
      render json: { error: buyer_foam.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /buyer_foams/1
  def update
    buyer_foam = BuyerFoam.find_by(id: params[:id])
    if buyer_foam
      if current_broker || buyer_foam.buyer_id == @current_buyer.id
        if buyer_foam.update(buyer_foam_params)
          render json: buyer_foam
        else
          render json: { error: buyer_foam.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render_unauthorized
      end
    else
      render json: { error: "BuyerFoam not found" }, status: :not_found
    end
  end

  # DELETE /buyer_foams/1
  def destroy
    buyer_foam = BuyerFoam.find_by(id: params[:id])
    if buyer_foam
      if current_broker || buyer_foam.buyer_id == @current_buyer.id
        buyer_foam.destroy
        head :no_content
      else
        render_unauthorized
      end
    else
      render json: { error: "BuyerFoam not found" }, status: :not_found
    end
  end

  private

  def buyer_foam_params
    params.require(:buyer_foam).permit(:supplier_name, :country, :boxMark, :variety, :s1, :stems, :quantity, :boxtype, :cost, :amount, :price, :total, :duty, :assigned_to)
  end

  def deny_buyer
    render_unauthorized unless current_broker
  end

  def deny_access
    render_unauthorized unless current_buyer || (current_buyer && buyer_foam_belongs_to_current_buyer?)
  end

  def buyer_foam_belongs_to_current_buyer?
    buyer_foam = BuyerFoam.find_by(id: params[:id])
    buyer_foam && buyer_foam.buyer_id == @current_buyer.id
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
