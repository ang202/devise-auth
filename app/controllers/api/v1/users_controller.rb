class Api::V1::UsersController < ApplicationController
  include Jasonify
  before_action :authorize_access_request!, only: [:update]
  before_action :find_user, only: [:update]

  def update
    if @user.update(user_params)
      json_message "User updated successfully", true, @user.roles,:ok
    else
      json_message "Something wrong", false, {}, :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:role_ids)
    end

    def find_user 
      @user = authorize User.find(params[:id])
    end
end