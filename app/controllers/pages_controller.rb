class PagesController < ApplicationController
  before_action :top, only: :home
  before_action :new_expense, only: %i[home new]
  before_action :filter_earnings, only: :home
  before_action :filter_spendings, only: :home

  def home
    @balance = @earnings - @spendings
    if @balance == 0
      @color = "text-dark"
    elsif @balance.negative?
      @color = "text-danger"
    else
      @color = "text-success"
    end
    @days = params[:days]&.to_i || false

    return if @earnings.zero?

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

  def top
    @user = current_user
    @top = Expense.where(user: @user).order(value: :desc).limit(5)
  end

  def new_expense
    @expense = Expense.new
  end

  def filter_earnings
    @earnings = Income.where(user_id: current_user.id).pluck(:value).reduce(:+)
    @earnings = 0 if @earnings.nil?
  end

  def filter_spendings
    @spendings = Expense.where(user_id: current_user.id).pluck(:value).reduce(:+)
    @spendings = 0 if @spendings.nil?
  end
end
