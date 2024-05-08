class UsersController < ApplicationController
    before_action :authenticate_user!
    def index
        @users = User.order(:id)
    end
    def bulk_delete
        @selected_users = User.where(id: params.fetch(:user_ids, []).compact)

        if @selected_users.empty?
          # Handle case where no users are selected
          redirect_to root_path,notice: "No users selected for deletion."
          
        else
            # puts "555555555555555555555555anything55555555555555555555555"
            # binding.b
            @selected_users.destroy_all
            redirect_to root_path
          
        end
      end 
    def new
      @user = User.new
    end
    def bulk_update
  
        @selected_users=User.where(id:params.fetch(:user_ids,[]).compact)
        #binding.b
        if params[:commit]=="Blocked"
          @selected_users.update_all(status: :blocked)
          redirect_to root_path, notice: "User status updated successfully."
        elsif params[:commit]=="active"
          @selected_users.update_all(status: :active)
          redirect_to root_path, notice: "User status updated successfully."
        else
          redirect_to root_path, notice: "No user selected."
        end
    end
    def user_params
    params.require(:user).permit(:name, :email, :status)
    end
end
