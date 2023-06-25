class MainController < ApplicationController
  def index
    redirect_to reports_report_by_dates_path(index_page: true)
  end
end
