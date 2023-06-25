class ReportsController < ApplicationController
  before_action :set_category, only: %i[  index report_by_category ]
  before_action :set_dates, only: %i[  index report_by_category report_by_dates ]

  def index
    
  end

  def report_by_category
    operations = Operation.where(odate: params[:start_date]..params[:end_date]).
                           where(category_id: params[:category_id])
    @total_amount_by_category = operations.sum(:amount)
    operations = operations.order(:odate).map { |o| [o.odate.strftime("%d.%m.%Y").to_s, o.amount] }
    @dates = operations.map { |o| o[0] }
    @amount = operations.map { |o| o[1] }
  end

  def report_by_dates
    @operations_by_categories = Operation.select('SUM(operations.amount) AS sum_amount, categories.name AS category_name').
                 joins(:category).where(odate: params[:start_date]..params[:end_date]).group(:category_id).
                 map { |o| [o.category_name, o.sum_amount] }
    @total_sum_amount_by_date = Operation.where(odate: params[:start_date]..params[:end_date]).sum(:amount)
    @category_name = @operations_by_categories.map { |o| o[0] }
    @sum_amount = @operations_by_categories.map { |o| o[1] }
  end

  private
    def set_category
      @categories = Category.all
      if params.key?(:category_id)
        @category_id = params[:category_id]
      else
        @category_id = Category.first.id
        params[:category_id] = @category_id
      end 
    end

    def set_dates
      if !params.key?(:start_date)
        params[:start_date] = Date.today - Date.today.day + 1
        params[:end_date] = Date.today
      end
    end
end
