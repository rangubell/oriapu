class DepartmentsController < ApplicationController
  def show
    @department = Department.find(params[:id])
    @schedules = @department.users.map(&:schedules).flatten
  end
end
