class EmployeesController < ApplicationController

  def show
    @employee = Employee.find(params[:id])
    @tickets = @employee.tickets.sort_old_to_new
    # Does this logic live in View OR Controller? 
    # @oldest_ticket = @tickets.first.subject
  end

  def update
    employee = Employee.find(params[:id])
    the_tk = Ticket.find(params[:ticket_id])
    the_tk.update(employee_id: employee.id)
    
    redirect_to "/employees/#{employee.id}"
  end

end