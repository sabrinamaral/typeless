class CreateIncomes < ActiveRecord::Migration[7.0]
  def change
    create_table :incomes do |t|
      t.date :date
      t.string :title
      t.text :description
      t.integer :quantity
      t.float :value
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
