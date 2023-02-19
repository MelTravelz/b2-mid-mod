class Ticket < ApplicationRecord
  belongs_to :employee

  def self.sort_old_to_new
    order(age: :desc)
  end
end