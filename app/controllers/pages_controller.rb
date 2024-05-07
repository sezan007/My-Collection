class PagesController < ApplicationController
  def home
    @users = User.all # Assuming User is your model representing users
  end
  def users
  end

  def admins
  end
end
