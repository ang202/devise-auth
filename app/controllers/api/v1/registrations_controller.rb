class Api::V1::RegistrationsController < Devise::RegistrationsController
  include Jasonify
  def create
    build_resource(sign_up_params)
    resource.save
    if resource.persisted?
      if sign_up(resource_name, resource)
        # json_message('User created succesfully',true,resource,:ok)
        payload = { user_id: resource.id }
        session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
        tokens = session.login
        response.set_cookie(JWTSessions.access_cookie,
                            value: tokens[:access],
                            httponly: true,
                            secure: Rails.env.production? )

        render json: { csrf: tokens[:csrf] }
      else
        render json: { error: resource.errors.full_messages.join(' ') }, status: :unprocessable_entity
      end
    else
      json_message resource.errors.full_messages.each, false, resource, :bad_request
    end
  end

  private
  def sign_up_params
    params.require(:user).permit(:email, :password)
  end
end