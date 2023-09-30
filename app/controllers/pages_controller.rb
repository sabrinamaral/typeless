class PagesController < ApplicationController
  before_action :new_expense, only: %i[home new]
  before_action :set_user, only: %i[home top]

  def home
    @days = params[:days]&.to_i
    @earnings = 0 if @earnings.nil?
    @spendings = 0 if @spendings.nil?
    if @days
      @incomes_by_month = Income.where(user: @user, date: @days.days.ago..Date.today).group_by_day(:date, format: "%b %e").sum(:value)
      @expenses_by_month = Expense.where(user: @user, date: @days.days.ago..Date.today).group_by_day(:date, format: "%b %e").sum(:value)
      @expenses_by_category = Expense.where(user: @user, date: @days.days.ago..Date.today).group(:category).sum(:value)
      @earnings = Income.where(user: current_user, date: @days.days.ago..Date.today).pluck(:value).reduce(:+)
      @spendings = Expense.where(user: current_user, date: @days.days.ago..Date.today).pluck(:value).reduce(:+)
      @top_five = Expense.where(user: current_user, date: @days.days.ago..Date.today).order(value: :desc).limit(5)
    else
      @incomes_by_month = Income.where(user: @user, date: "#{Date.current.year}-01-01".to_datetime..Date.current).group_by_month(:date, format: "%b %Y").sum(:value)
      @expenses_by_month = Expense.where(user: @user, date: "#{Date.current.year}-01-01".to_datetime..Date.current).group_by_month(:date, format: "%b %Y").sum(:value)
      @expenses_by_category = Expense.where(user: @user, date: "#{Date.current.year}-01-01".to_datetime..Date.current).group(:category).sum(:value)
      @earnings = Income.where(user: current_user, date: "#{Date.current.year}-01-01".to_datetime..Date.today).pluck(:value).reduce(:+)
      @spendings = Expense.where(user: current_user, date: "#{Date.current.year}-01-01".to_datetime..Date.today).pluck(:value).reduce(:+)
      @top_five = Expense.where(user: current_user, date: "#{Date.current.year}-01-01".to_datetime..Date.today).order(value: :desc).limit(5)
    end

    @balance = @earnings - @spendings
    @percentage = ((@spendings / @earnings) * 100).round
  end

  def new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user = current_user
    respond_to do |format|
      if @expense.save
        format.html { redirect_to root_path, notice: "Expense was successfully created." }
      else
        format.html { render "new", status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:photo)
  end

  def new_expense
    @expense = Expense.new
  end

  def set_user
    @user = current_user
  end
end
