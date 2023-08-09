class BuyersController < ApplicationController
    # before_action :set_staff, only: [:destroy]
    # before_action :authenticate_staff, only: [:show, :create, :update, :destroy]
    before_action :deny_access, only: [:destroy, :update, :update, :show]
  
  
    def index
      @buyers = Buyer.all
      Rails.logger.info(@buyers.inspect) # Log the retrieved buyers
      render json: @buyers
    end
  
    def create
      buyer = Buyer.create(buyer_params)
      if buyer.save
        render json: buyer, status: :created
      else
        render json: { error: buyer.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      render json: buyer, status: :ok
    end
  
    def update
      Rails.logger.info("Updating buyer with ID: #{params[:id]}")
      Rails.logger.info("Buyer params: #{buyer_params.inspect}")
      buyer = set_buyer
      if buyer.update(buyer_params)
        render json: buyer
      else
        render json: { error: buyer.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      buyer = set_buyer
      if buyer
        buyer.destroy
        head :no_content
      else
        render json: { error: "Buyer not found" }, status: :not_found
      end
    end
  
    private
  
    def set_buyer
      buyer = Buyer.find(params[:id])
    end
  
    def buyer_params
      params.permit(:buyer_name, :email, :password, :password_confirmation)
    end    
  
    def deny_access
      render_unauthorized unless current_broker
    end
  
    def render_unauthorized
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
    
  end