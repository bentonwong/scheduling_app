class SessionController < ApplicationController

  def home
    @employee = Employee.new
    @employee_list = {}
    Employee.all.each do |employee|
      @employee_list[employee.name] = employee.id
    end
  end

  def create
    @employee = Employee.find_by_id(params[:employee][:id])
    session.clear
    session[:employee_id] = @employee.id
    redirect_to @employee #need to redirect to employee dashboard
  end

  def destroy
  end

end
