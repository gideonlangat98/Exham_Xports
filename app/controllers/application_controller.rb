class ApplicationController < ActionController::API
    include JsonWebToken
  
    # before_action :authenticate_admin
    # before_action :authenticate_staff
    
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  
  
    private
  
    def render_invalid(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
  
    def render_not_found(exception)
      render json: { error: "#{exception.model} not found" }, status: :not_found
    end
  
    def authenticate_buyer
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      decoded = jwt_decode(header)
    
      if decoded == "Token not found"
        render json: { error: 'Not Authenticated' }, status: :unauthorized
      else
        buyer_id = decoded[:buyer_id] if decoded.key?(:buyer_id)
    
        @current_buyer = Buyer.find_by(id: buyer_id)
      end
    end
  
    def current_buyer
      @current_buyer ||= authenticate_buyer
    end
    
    def authenticate_supplier
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      decoded = jwt_decode(header)
    
      if decoded == "Token not found"
        render json: { error: 'Not Authenticated' }, status: :unauthorized
      else
  
        supplier_id = decoded[:supplier_id] if decoded.key?(:supplier_id)
        @current_supplier = Supplier.find_by(id: supplier_id)
      end
    end
  
    def current_supplier
      @current_supplier ||= authenticate_supplier
    end

    def authenticate_broker
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        decoded = jwt_decode(header)
      
        if decoded == "Token not found"
          render json: { error: 'Not Authenticated' }, status: :unauthorized
        else
    
          broker_id = decoded[:broker_id] if decoded.key?(:broker_id)
          @current_broker = Broker.find_by(id: broker_id)
        end
      end
    
      def current_broker
        @current_broker ||= authenticate_broker
      end
    
  
  
    # def authorize_staff
    #   render_unauthorized unless current_staff
    # end
  
    # def authorize_admin
    #   render_unauthorized unless current_supplier
    # end
  
    def render_unauthorized
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
  
