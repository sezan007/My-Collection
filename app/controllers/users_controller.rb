class UsersController < ApplicationController
    before_action :authenticate_user!
    def generate_api_token
      current_user.regenerate_api_token
      redirect_to user_path, notice: 'API Token generated'
    end
    def index
        @users = User.order(:id)
    end
    def show
    end
    def bulk_delete
        if !params[:user_ids].present?
            redirect_to admins_admin_path,notice: "You must choose before any action !"

        else
            @selected_users = User.where(id: params.fetch(:user_ids, []).compact)

            if @selected_users.empty?
              # Handle case where no users are selected
              redirect_to admins_admin_path,notice: "No users selected for deletion."
              
            else
                # puts "555555555555555555555555anything55555555555555555555555"
                # binding.b
                @selected_users.destroy_all
                if User.any?
                    redirect_to request.referrer, notice: "Users deleted successfully."
                  else
                    redirect_to root_path, notice: "All users deleted successfully."
                end
            end
        end

      end 
    def new
      @user = User.new
    end
    def bulk_update
        if !params[:user_ids].present?
            redirect_to admins_admin_path,notice: "You must choose before any action !"
        else
            @selected_users=User.where(id:params.fetch(:user_ids,[]).compact)
            #binding.b
            if params[:commit]=="Blocked"
              @selected_users.update_all(status: :blocked)
              redirect_to admins_admin_path, notice: "User status updated successfully."
            elsif params[:commit]=="active"
              @selected_users.update_all(status: :active)
              redirect_to admins_admin_path, notice: "User status updated successfully."
            elsif params[:commit]=="Admin"
                @selected_users.update_all(role: :admin)
              redirect_to admins_admin_path, notice: "Admin updated successfully."
            elsif params[:commit]=="User"
                @selected_users.update_all(role: :user)
              redirect_to admins_admin_path, notice: "Downgraded to User."
            else
              redirect_to admins_admin_path, notice: "No user selected."
            end
        end

    end
    def user_params
      params.require(:user).permit(:name, :email, :status)
    end
    def generate_api_token
      current_user.regenerate_api_token
      redirect_to current_user, notice: 'API Token generated'
    end
end
