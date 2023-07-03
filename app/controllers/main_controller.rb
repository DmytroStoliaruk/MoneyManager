class MainController < ApplicationController
  def index
    # get data for rendering main page  
    @categories_amount = Category.count
    @operations_amount = Operation.count
    @total_amount = Operation.sum(:amount)
    @operations_by_categories = Operation.select('SUM(operations.amount) AS sum_amount, categories.name AS category_name').
                                                joins(:category).group(:category_name).where(odate: params[:start_date]..params[:end_date]).
                                                map { |o| [o.category_name, o.sum_amount] }   
    @category_name = @operations_by_categories.map { |o| o[0] }
    @sum_amount = @operations_by_categories.map { |o| o[1] }

    # set global value paginates_per
    $global_paginates_per = 7
  end
end
