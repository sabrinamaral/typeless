class IncomesController < ApplicationController
  before_action :set_user, only: :index
  before_action :find_income, only: %i[show edit update destroy]

  def index
    @days = params[:days]&.to_i

    if params[:start_date]
      @incomes = current_user.incomes.where(date: params[:start_date].to_date..params[:end_date].to_date).order(:date)
    elsif @days
      @incomes = current_user.incomes.where(date: @days.days.ago..Date.today).order(:date)
    else
      @incomes = current_user.incomes.where(date: "#{Date.current.year}-01-01".to_date..Date.today).order(date: :desc)
    end
  end

  def show
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
  end

  def update
    if @income.update(income_params)
      redirect_to incomes_path, notice: "Income was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
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

  def find_income
    @income = Income.find(params[:id])
  end
end
