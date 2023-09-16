class AddHashToExpense < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses, :ocr_hash, :string
  end
end
