class Category < ApplicationRecord
  has_many :operations
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  
  # set paginates_per from global variable (init in main_controller)
  paginates_per $global_paginates_per
end
