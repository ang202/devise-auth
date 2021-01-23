class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  
  def update?
    (@user.has_role?(:teacher) && @record.user == @user)|| @user.has_role?(:admin) 
  end

  def create?
    @user.has_role?(:teacher)
  end

  def destroy?
    (@user.has_role?(:teacher) && @record.user == @user )|| @user.has_role?(:admin) 
  end
end
