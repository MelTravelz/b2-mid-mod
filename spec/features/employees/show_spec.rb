require 'rails_helper'

RSpec.describe '/employees/:id', type: :feature do
  let(:dept1) { Department.create!(name: "IT", floor: "Penthouse") }

  let(:empl1) { Employee.create!(name: "Adam B.", level: 1, department_id: dept1.id) }
  let(:empl2) { Employee.create!(name: "Diana W.", level: 5, department_id: dept1.id) }


  let!(:tk1) { Ticket.create!(subject: "Broken Computer", age: 1, employee_id: empl1.id) }
  let!(:tk2) { Ticket.create!(subject: "Mouse no Battery", age: 3, employee_id: empl1.id) }
  let!(:tk3) { Ticket.create!(subject: "Unitilialized Constant Error", age: 2, employee_id: empl1.id) }
  let!(:tk4) { Ticket.create!(subject: "Small Electircal Fire", age: 4, employee_id: empl2.id) }

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
        # This is NOT necessary? 
        # expect(page).to have_content("#{tk3.subject}, Age: #{tk1.age}")
      end

      it "tickets are sorted by oldest to youngest" do 
        within "#all_tks" do
          expect("#{tk2.subject}").to appear_before("#{tk3.subject}")
          expect("#{tk3.subject}").to appear_before("#{tk1.subject}")  
        end
      end
    
      it "the oldest ticket assigned to the employee listed separately" do
        expect(page).to have_content("Oldest Ticket: #{tk2.subject}")
      end

      it "I do NOT any tickets listed that are not assigned to the employee" do
        expect(page).to_not have_content("#{tk4.subject}")
      end

      it "a form to add a ticket to this department" do
        expect(page).to have_content("Add Ticket to Department")
        expect(page).to have_field(:ticket_id)
        expect(page).to have_button("Submit")

        # Are we sure that this shouldn't be tested here??
        # expect(current_path).to eq("/employees/#{empl2.id}")
      end

      it "when I fill in the form with the id of a ticket that already exists in the database
      and I click submit, then I am redirected back to that employees show page and
      I see the ticket's subject now listed" do 

        fill_in("Ticket Id Number:", with: "#{tk4.id}")
        click_button("Submit")
        expect(current_path).to eq("/employees/#{empl1.id}")

        expect(page).to have_content("#{empl1.name} Page")
        expect(page).to have_content("Department: #{empl1.department.name}")
        expect(page).to have_content("#{tk4.subject}, Age: #{tk4.age}")
      end
    end
  end   
end

# it "when I fill in the form with the id of a ticket that already exists in the database
      # and I click submit, then I am redirected back to that employees show page and
      # I see the ticket's subject now listed" do 

      #   fill_in("Ticket Id Number:", with: "#{tk4.id}")
      #   click_button("Submit")
      #   expect(current_path).to eq("/employees/#{empl2.id}")

      #   expect(page).to have_content("#{empl2.name} Page")
      #   expect(page).to have_content("Department: #{empl2.department.name}")
      #   expect(page).to have_content("#{tk4.subject}, Age: #{tk4.age}")
      # end