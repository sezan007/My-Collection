class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user

  def require_user
    if current_user.admin?
      flash[:notice] = "You are admin."
    else
      redirect_to root_path, notice: "You are Not admin."
    end
  end

  def admin
    @users = User.order(:id) # Assuming User is your model representing users
  end
end
