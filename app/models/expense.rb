class Expense < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_all_fields, against: [:description, :place, :category, :payment_type, :value],
  using: { tsearch: { prefix: true } }
  PAYMENT_TYPE = ["cash", "credit card", "debit card", "pix"]
  CATEGORY = [
    "restaurant",
    "groceries",
    "transport",
    "drug store",
    "rent",
    "clothes",
    "health insurance",
    "house maintenance",
    "others"
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
