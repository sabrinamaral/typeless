class Expense < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_all_fields, against: %i[description place category payment_type value],
                                      using: { tsearch: { prefix: true } }

  PAYMENT_TYPE = ["cash", "credit card", "debit card", "pix"]
  CATEGORY = [
    "Groceries",
    "Natural warehouse",
    "Shopping personal",
    "Shopping house",
    "Utilities",
    "Eating out",
    "Leisure",
    "Transport",
    "Body corporate",
    "Health & Beauty",
    "Drug Store",
    "Cleaning & maintenance",
    "Taxes",
    "Streeming",
    "Miscellaneous",
    "Rent's expenses",
    "Health Insurance",
    "Travel",
    "Fixed assets / Goods"
  ]

  belongs_to :user
  has_one_attached :photo

  validates :date, presence: true
  validates :place, presence: true
  validates :quantity, presence: true
  validates :unity, presence: true
  validates :value, presence: true
  validates :category, presence: true
end
