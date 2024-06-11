class Api::V1::CollectionsController < ApplicationController
    before_action :authenticate_user_with_token!
  
    def index
      user = User.find_by(api_token: request.headers['Authorization'])
      if user
        collections = user.collections
        render json: collections, status: :ok
      else
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    end
  
    private
  
    def authenticate_user_with_token!
      render json: { error: 'Token not provided' }, status: :unauthorized unless request.headers['Authorization'].present?
    end
  end
  