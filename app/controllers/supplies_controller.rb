class SuppliesController < ApplicationController
  before_action :authenticate_supplier, only: [:index, :show, :update]
  before_action :deny_supplier, only: [:show, :update, :destroy]
  before_action :deny_access, only: [:show, :update, :destroy]
  
  
    # GET /supply
    def index
      if current_broker
        supply = Supply.all
      else
        supply = Supply.where(assign_to: @current_supplier.supplier_name)
      end
  
      render json: supply, status: :ok
    end
  
    # GET /supply/1
    def show
      supply = Supply.find_by(id: params[:id])
      if supply
        if current_broker || supply.supplier_id == @current_supplier.id
          render json: supply
        else
          render_unauthorized
        end
      else
        render json: { error: "Supply not found" }, status: :not_found
      end
    end
  
    # POST /supply
    
  def create
    supplier_name = params[:supplier_name]
      @current_supplier = Supplier.find_by(supplier_name: supplier_name)

      if @current_supplier.nil?
        render json: { error: "Supplier not found with name '#{supplier_name}'" }, status: :unprocessable_entity
        return
      end

     supply = Supply.new(supply_params)
     supply.supplier_id = @current_supplier.id
  
    if supply.save
      render json: supply, status: :created
    else
      render json: { error: supply.errors.full_messages }, status: :unprocessable_entity
    end
  end

    # PATCH/PUT /supply/1
    def update
      supply = Supply.find_by(id: params[:id])
      if supply
        if current_broker || supply.supplier_id == @current_supplier.id
          if supply.update(supply_params)
            render json: supply
          else
            render json: { error: supply.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render_unauthorized
        end
      else
        render json: { error: "Supply not found" }, status: :not_found
      end
    end
  
    # DELETE /supply/1
    def destroy
      supply = Supply.find_by(id: params[:id])
      if supply
        if current_broker || supply.supplier_id == @current_supplier.id
          supply.destroy
          head :no_content
        else
          render_unauthorized
        end
      else
        render json: { error: "Supply not found" }, status: :not_found
      end
    end
  
    private
  
    def supply_params
      params.permit(:supplier_credentials, :country, :assign_to, :boxmark, :type_flower,:variety, :s1, :quantity, :boxtype, :stems, :cost, :amount, :total)
    end
  
    def deny_supplier
      render_unauthorized unless current_broker
    end
  
    def deny_access
      render_unauthorized unless current_supplier || (current_supplier && supply_belongs_to_current_supplier?)
    end
  
    def supply_belongs_to_current_supplier?
      supply = Supply.find_by(id: params[:id])
      supply && supply.supplier_id == @current_supplier.id
    end
  
    def render_unauthorized
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end