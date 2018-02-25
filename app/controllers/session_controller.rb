class SessionController < ApplicationController
  before_action :authorized?, except: [:home, :create]

  def home
    if !signed_in?
      @employee = Employee.new
      @employees = Employee.all
    else
      current_user_admin? ? (redirect_to teams_path) : (redirect_to dashboard_path)
    end
  end

  def create
    if !params[:employee]
      redirect_to root_path
    else
      reset_session
      @employee = Employee.find_by_id(session_params[:id])
      session[:employee_id] = @employee.id
      current_user_admin? ? (redirect_to teams_path) : (redirect_to dashboard_path)
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

    def session_params
      params.require(:employee).permit(:id)
    end

end
