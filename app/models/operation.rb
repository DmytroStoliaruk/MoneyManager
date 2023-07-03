class Operation < ApplicationRecord
  belongs_to :category
  validates :amount, numericality: {greater_than: 0}
  validates :odate, presence: true
  validates :description, presence: true

  # set paginates_per from global variable (init in main_controller)
  paginates_per $global_paginates_per
end
