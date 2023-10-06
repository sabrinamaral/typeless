class ExpensesController < ApplicationController
  include ApplicationHelper
  before_action :find_expense, only: %i[show edit update destroy]
  before_action :set_user, only: :index
  before_action :new_expense, only: %i[new]

  def index
    @days = params[:days]&.to_i

    if params[:start_date]
      @expenses = current_user.expenses.where(date: params[:start_date].to_date..params[:end_date].to_date).order(:date)
    elsif @days
      @expenses = current_user.expenses.where(date: @days.days.ago..Date.today).order(:date)
    else
      @expenses = current_user.expenses.where(date: "#{Date.current.year}-01-01".to_date..Date.today).order(date: :desc)
    end
  end

  def show
  end

  def new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user = current_user
    respond_to do |format|
      if @expense.save
        fill_params_from_photo
        format.html { redirect_to expenses_path, notice: "Expense was successfully created." }
      else
        format.html { render "new", status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expenses_path, notice: "Expense was successfully updated." }
      else
        format.html { render "edit", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_path, notiice: "Expense was successfully deleted."
  end

  private

  def fill_params_from_photo
    return if @expense.photo.url.nil? || @expense.ocr_hash.present?

    ocr_hash = ocr_veryfi(@expense.photo.url)
    @expense.update(
      ocr_hash: ocr_hash,
      value: ocr_hash["total"],
      date: ocr_hash["date"],
      place: ocr_hash["vendor"]["name"]
    )
  end

  def expense_params
    params.require(:expense).permit(:date, :place, :description, :quantity, :unity, :value, :category, :payment_type, :photo)
  end

  def find_expense
    @expense = Expense.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def new_expense
    @expense = Expense.new
  end

end
