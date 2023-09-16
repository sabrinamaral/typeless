class IncomesController < ApplicationController
  before_action :set_user, only: :index

  def index
    @days = params[:days]&.to_i || 7
    @incomes = current_user.incomes.where(date: @days.days.ago..Date.today).order(:date)
    @expense = Expense.new
  end

  def show
    @income = Income.find(params[:id])
  end

  def new
    @income = Income.new
    @user = current_user
  end

  def create
    @income = Income.new(income_params)
    @user = current_user
    @income.user = @user

    respond_to do |format|
      if @income.save
        format.html { redirect_to incomes_path, notice: "Income was successfully added." }
        @income.save
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @income = Income.find(params[:id])
  end

  def update
    @income = Income.find(params[:id])

    if @income.update(income_params)
      redirect_to incomes_path, notice: "Income was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @income = Income.find(params[:id])
    @income.destroy

    redirect_to incomes_path, notice: "Income was successfully deleted."
  end

  private

  def income_params
    params.require(:income).permit(:date, :title, :description, :quantity, :value)
  end

  def set_user
    @user = current_user
  end
end
