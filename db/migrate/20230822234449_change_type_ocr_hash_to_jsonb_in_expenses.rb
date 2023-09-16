class ChangeTypeOcrHashToJsonbInExpenses < ActiveRecord::Migration[7.0]
  def change
    change_column :expenses, :ocr_hash, 'jsonb USING ocr_hash::jsonb'
  end
end
