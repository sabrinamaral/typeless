class ExpensesController < ApplicationController
  include ApplicationHelper
  before_action :find_expense, only: %i[show edit update destroy]
  before_action :set_user, only: :index

  def index
    @days = params[:days]&.to_i || 7
    @expenses = current_user.expenses.where(date: @days.days.ago..Date.today).order(:date)
    @expense = Expense.new
  end

  def show
  end

  def new
    @expense = Expense.new
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
end
