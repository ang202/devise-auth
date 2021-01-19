class Api::V1::SessionsController < Devise::SessionsController
    include Jasonify
    before_action :sign_in_params, only: [:create]
    before_action :check_user, only: [:create]
    before_action :authorize_access_request!, only: [:destroy]
    
    def create
      if @user.valid_password?(sign_in_params[:password])
        sign_in @user
        json_message('User signed in succesfully',true,@user,:ok)
        payload = { user_id: @user.id }
        session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
        tokens = session.login
        response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)
        # render json: { csrf: tokens[:csrf] } 
      else
        json_message "Email or password invalid", false, {},:bad_request
      end
    end
  
    def destroy
      sign_out @user
      session = JWTSessions::Session.new(payload: payload)
      session.flush_by_access_payload
    end
    
    private
    def sign_in_params
      params.require(:user).permit(:email, :password)
    end
  
    def check_user 
      @user = User.find_for_database_authentication(email: sign_in_params[:email])
      @user || json_message('Invalid account', false, {}, :bad_request)
    end
  
    def respond_to_on_destroy
      head :ok
    end
end