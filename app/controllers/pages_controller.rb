class PagesController < ApplicationController
  before_action :authenticate_user!
  # current_user.admin?
  def home
    @users = User.order(:id) # Assuming User is your model representing users
  end
  def users
  end
  # def require_user
  #   if current_user.admin?
  #     flash[:notice] = "You are admin."
  #   else
  #     redirect_to root_path, notice: "Not admin."
  #   end
  # end
  

  def admins
    @users = User.order(:id) # Assuming User is your model representing users
  end
  def toggle_theme
    # binding.b
    current_user.update(light_theme: !current_user.light_theme)
    # Optionally, you can redirect to a specific path after updating the theme
    redirect_to request.referrer, notice: "Theme toggled."
  end

end
