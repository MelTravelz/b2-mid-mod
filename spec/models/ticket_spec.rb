require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'relationships' do
    it { should belong_to :employee }
  end

  describe "class methods" do
    let(:dept1) { Department.create!(name: "IT", floor: "Penthouse") }
    let(:empl1) { Employee.create!(name: "Adam B.", level: 1, department_id: dept1.id) }
  
    let!(:tk1) { Ticket.create!(subject: "Broken Computer", age: 1, employee_id: empl1.id) }
    let!(:tk2) { Ticket.create!(subject: "Mouse no Battery", age: 3, employee_id: empl1.id) }
    let!(:tk3) { Ticket.create!(subject: "Unitilialized Constant Error", age: 2, employee_id: empl1.id) }
  
    describe "#sort_old_to_new" do
      it "can order tickets from oldest to newest" do
        expect(Ticket.sort_old_to_new).to eq([tk2, tk3, tk1])
      end
    end
  end

end