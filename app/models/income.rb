class Income < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_all_fields, against: [:description, :title, :value],
  using: { tsearch: { prefix: true } }
  belongs_to :user

  validates :date, :title, :value, presence: true
end
