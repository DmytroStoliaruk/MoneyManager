class ReportsController < ApplicationController
  before_action :set_category, only: %i[  index report_by_category report_by_dates]
  before_action :set_dates, only: %i[  index report_by_category report_by_dates ]

  def index
    
  end

  def report_by_category   
    # if no operation - no reports
    if Operation.count == 0
      redirect_to root_path
    end

    # prepare data for report
    operations = Operation.where(odate: params[:start_date]..params[:end_date]).
                           where(category_id: params[:category_id])                                      
    @total_amount_by_category = operations.sum(:amount)
    operations = operations.order(:odate).map { |o| [o.odate.strftime("%d.%m.%Y").to_s, o.amount] }
    @dates = operations.map { |o| o[0] }
    @amount = operations.map { |o| o[1] }
  end

  def report_by_dates
    # if no operation - no reports
    if Operation.count == 0
      redirect_to root_path
    end

    # prepare data for report
    @operations_by_categories = Operation.select('SUM(operations.amount) AS sum_amount, categories.name AS category_name').
                 joins(:category).group(:category_name).where(odate: params[:start_date]..params[:end_date]).
                 map { |o| [o.category_name, o.sum_amount] }   
    @total_sum_amount_by_date = Operation.where(odate: params[:start_date]..params[:end_date]).sum(:amount)
    @category_name = @operations_by_categories.map { |o| o[0] }
    @sum_amount = @operations_by_categories.map { |o| o[1] }
  end

  private
    def set_category
      # if database is empty go to main page...
      if Category.count == 0 
        return redirect_to root_path
      end
      @categories = Category.all
      if params.key?(:category_id)
        @category_id = params[:category_id]
      else
        # set first category as active by default
        @category_id = Category.first.id     
        params[:category_id] = @category_id
      end 
    end

    def set_dates
      if !params.key?(:start_date)
        # set date params dy default (current month)
        params[:start_date] = (Date.today -  30).to_s
        params[:end_date] = Date.today.to_s
      end
    end
end
