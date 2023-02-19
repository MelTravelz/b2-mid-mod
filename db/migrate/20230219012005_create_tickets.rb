class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.integer :age
      t.references :employee, foreign_key: true
      
      t.timestamps
    end
  end
end
