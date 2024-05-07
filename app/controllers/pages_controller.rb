class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
    @users = User.all # Assuming User is your model representing users
  end
  def users
  end

  def admins
  end
  def toggle_theme
    # binding.b
    current_user.update(light_theme: !current_user.light_theme)
    # Optionally, you can redirect to a specific path after updating the theme
    redirect_to root_path, notice: "Theme toggled."
  end

end
