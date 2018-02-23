module ApplicationHelper

  def current_user
    @current_user ||= Employee.find_by(id: session[:employee_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user_admin?
    current_user.admin
  end

  def current_year
    Time.current.year
  end

  private

    def authorized?
      redirect_to root_path if !signed_in?
    end

    def employee_authorized?
      redirect_to root_path if !current_user_admin?
    end

end
