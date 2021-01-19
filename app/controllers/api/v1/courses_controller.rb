class Api::V1::CoursesController < ApplicationController
  include Jasonify
  before_action :authorize_access_request!, only: [:index]
  def index
    @course = Course.all
      json_message "",true,@course,:ok
  end
end 
