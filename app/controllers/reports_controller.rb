class ReportsController < ApplicationController
  before_action :set_user, only: :index
  def index
    if params[:start_date]
      filter_by_params(@user, params[:start_date], params[:end_date])
    else
      filter_by_curr_year(@user)
    end

    @earnings = 0 if @earnings.nil?
    @spendings = 0 if @spendings.nil?
    @balance = @earnings - @spendings
    return if @earnings.zero?
  end

  private

  def filter_by_params(user, start_date, end_date)
    @earnings = Income.where(user: user, date: start_date.to_date..end_date.to_date).pluck(:value).reduce(:+)
    @spendings = Expense.where(user: user, date: start_date.to_date..end_date.to_date).pluck(:value).reduce(:+)
  end

  def filter_by_curr_year(user)
    @earnings = Income.where(user: user, date: "#{Date.current.year}-01-01".to_date..Date.today).pluck(:value).reduce(:+)
    @spendings = Expense.where(user: user, date: "#{Date.current.year}-01-01".to_date..Date.today).pluck(:value).reduce(:+)
    @earnigns_by_month = Income.where(user: user, date: "#{Date.current.year}-01-01".to_date..Date.current).group_by_month(:date, format: "%b %Y").sum(:value).to_json
    @expenses_by_month = Expense.where(user: user, date: "#{Date.current.year}-01-01".to_date..Date.current).group_by_month(:date, format: "%b %Y").sum(:value).to_json
  end

  def set_user
    @user = current_user
  end
end
