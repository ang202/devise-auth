class Api::V1::CoursesController < ApplicationController
  include Jasonify
  before_action :authorize_access_request!, only: [:index, :update, :create]
  before_action :find_course, only: [:show, :update, :destroy]

  def index
    @course = Course.all
    json_message "You are #{current_user.roles.first.name}",true,@course,:ok
  end
  
  def create
    @course = authorize Course.new(course_params)
    @course.user = current_user
    if @course.save
      json_message "Courses created successfully", true, @course, :ok
    else
      json_message "Something wrong", false,{},:bad_request
    end
  end

  def update
    if @course.update(course_params)
      json_message "Update successfully", true,@course,:ok
    else
      json_message "Something wrong", false,{},:bad_request
    end
  end

  private
  def find_course 
    @course = authorize Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description)
  end
end 
