class SessionController < ApplicationController
  before_action :authorized?, except: [:home, :create]

  def home
    if !signed_in?
      @employee = Employee.new
      @employee_list = {}
      Employee.all.each do |employee|
        @employee_list[employee.name] = employee.id
      end
    else
      current_user_admin? ? (redirect_to teams_path) : (redirect_to dashboard_path)
    end
  end

  def create
    @employee = Employee.find_by_id(params[:employee][:id])
    session.clear
    session[:employee_id] = @employee.id
    if current_user_admin?
      redirect_to teams_path
    else
      redirect_to dashboard_path
    end
  end

  def destroy
    session.delete :employee_id
    redirect_to root_path
  end

end
