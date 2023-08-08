class SuppliersController < ApplicationController
    # before_action :set_supplier, only: [:destroy]
    # before_action :authenticate_staff, only: [:show, :create, :update, :destroy]
    before_action :deny_access, only: [:destroy, :update, :show]
  
    def index
      @supplier = Supplier.all
      Rails.logger.info(@suppliers.inspect)
      render json: @supplier
    end

    def create
      supplier = Supplier.create(supplier_params)
      if supplier.save
        render json: supplier, status: :created
      else
        render json: { error: supplier.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      render json: supplier, status: :ok
    end
  
    def update
      Rails.logger.info("Updating supplier with ID: #{params[:id]}")
      Rails.logger.info("Supplier params: #{supplier_params.inspect}")
      supplier = set_supplier
      if supplier.update(supplier_params)
        render json: supplier
      else
        render json: { error: supplier.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
  
    def destroy
      supplier = Supplier.find_by(id: params[:id])
      if supplier
        supplier.destroy
        head :no_content
      else
        render json: { error: "Supplier not found" }, status: :not_found
      end
    end
  
    private
  
    def set_supplier
      supplier = Supplier.find(params[:id])
    end
  
    def supplier_params
      params.permit(:supplier_name, :email,  :password, :password_confirmation )
    end
  
    def deny_access
      render_unauthorized unless authenticate_broker
    end
  
    def render_unauthorized
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  
  end
