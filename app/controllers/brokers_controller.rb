class BrokersController < ApplicationController
    before_action :deny_access, except: [:destroy, :create, :update, :show]
  
    def index
      broker = Broker.all
      render json: broker, status: :ok
    end
  
    def create
      broker = Broker.create(broker_params)
      if broker.save
        render json: broker, status: :created
      else
        render json: { error: broker.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      render json: broker, status: :ok
    end
  
    def update
      broker = set_broker
      if broker.update(broker_params)
        render json: broker
      else
        render json: { error: broker.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      broker.destroy
      head :no_content
    end
  
    private
  
    def set_broker
      broker = Broker.find(params[:id])
    end
  
    def broker_params
      params.permit(:id, :first_name, :last_name, :email, :password, :password_confirmation, :isbroker)
    end
  
    def deny_access
      render_unauthorized unless authenticate_broker
    end
  
    def render_unauthorized
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
