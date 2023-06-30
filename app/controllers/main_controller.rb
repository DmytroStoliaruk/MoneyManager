class MainController < ApplicationController
  def index
    @categories_amount = Category.count
    @operations_amount = Operation.count
    @total_amount = Operation.sum(:amount)
  end
end
