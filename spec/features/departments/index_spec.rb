require 'rails_helper'

RSpec.describe Department, type: :feature do
  describe 'department index page "/departments"' do
    before do
      @dept1 = Department.create!(name: "IT", floor: "Penthouse")
      @dept2 = Department.create!(name: "Accounting", floor: "Basement")

      @empl1 = Employee.create!(name: "Adam B.", level: 1, department_id: @dept1.id)
      @empl2 = Employee.create!(name: "Diana W.", level: 5, department_id: @dept1.id)
      @empl3 = Employee.create!(name: "Sam W.", level: 5, department_id: @dept1.id)

      @empl4 = Employee.create!(name: "Kassi L.", level: 3, department_id: @dept2.id)
      @empl5 = Employee.create!(name: "Mel F.", level: 3, department_id: @dept2.id)

      visit '/departments'
    end

    it "user story 1 - displays each depts name, floor, and all its employees" do
      expect(page).to have_content("Department Index Page")

      within "#dept_info-#{@dept1.id}" do
        expect(page).to have_content("Department: #{@dept1.name}, Floor: #{@dept1.floor}")
        expect(page).to have_content("Employees:")
        expect(page).to have_content("#{@empl1.name}")
        expect(page).to have_content("#{@empl2.name}")
        expect(page).to have_content("#{@empl3.name}")
        # expect(page).to have_content("Employees:\n#{@empl1.name}\n#{@empl2.name}\n#{@empl3.name}")
      end

      within "#dept_info-#{@dept2.id}" do
        expect(page).to have_content("Department: #{@dept2.name}, Floor: #{@dept2.floor}")
        expect(page).to have_content("Employees:")
        expect(page).to have_content("#{@empl4.name}")
        expect(page).to have_content("#{@empl5.name}")
        # expect(page).to have_content("#{@empl4.name}\n#{@empl5.name}")
      end
    end
  end
end
