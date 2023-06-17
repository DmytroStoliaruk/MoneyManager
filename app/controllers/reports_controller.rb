class ReportsController < ApplicationController
  def index
  end

  def report_by_category
    # @operations = Operation.where()
  end

  def report_by_dates
    @operations = Operation.all
  end
end
