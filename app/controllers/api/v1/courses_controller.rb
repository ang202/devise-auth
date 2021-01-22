class Api::V1::CoursesController < ApplicationController
  include Jasonify
  before_action :authorize_access_request!, only: [:index]
  def index
    @course = Course.all
    json_message "You are #{current_user.roles.first.name}",true,@course,:ok
  end
end 
