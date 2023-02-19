require 'rails_helper'

RSpec.describe '/employees/:id', type: :feature do
  let(:dept1) { Department.create!(name: "IT", floor: "Penthouse") }
  let(:empl1) { Employee.create!(name: "Adam B.", level: 1, department_id: dept1.id) }

  let!(:tk1) { Ticket.create!(subject: "Broken Computer", age: 1, employee_id: empl1.id) }
  let!(:tk2) { Ticket.create!(subject: "Mouse no Battery", age: 3, employee_id: empl1.id) }
  let!(:tk3) { Ticket.create!(subject: "Unitilialized Constant Error", age: 2, employee_id: empl1.id) }

  before do
    visit "/employees/#{empl1.id}"
  end

  describe "As a user" do
    context "when I visit the Employee show page I see" do
      it "the employee's name, department and a list of all of their tickets" do 
        expect(page).to have_content("#{empl1.name} Page")
        expect(page).to have_content("Department: #{empl1.department.name}")
        expect(page).to have_content("Tickets:")
        expect(page).to have_content("#{tk1.subject}, Age: #{tk1.age}")
        expect(page).to have_content("#{tk2.subject}, Age: #{tk2.age}")
        # expect(page).to have_content("#{tk3.subject}, Age: #{tk1.age}")
      end

      it "tickets are sorted by oldest to youngest" do 
        within "#all_tks" do
          expect("#{tk2.subject}").to appear_before("#{tk3.subject}")
          expect("#{tk3.subject}").to appear_before("#{tk1.subject}")  
        end
      end
    
      xit "I also see the oldest ticket assigned to the employee listed separately" do
        expect(page).to have_content("Oldest Ticket: #{tk2.subject}")
      end
    end
  end   
end
