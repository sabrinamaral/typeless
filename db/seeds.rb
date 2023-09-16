# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

income_titles = [
  "Salary",
  "Investment Returns",
  "Rental Income",
  "Interest Earnings",
  "Business Profits",
  "Gifts and Donations",
  "Dividend Payments",
  "Side Gig Earnings"
]

20.times do
  Expense.create!(
    date: Faker::Date.between(from: 1.year.ago, to: Date.today),
    place: Faker::Company.name,
    description: Faker::Commerce.product_name,
    quantity: Faker::Number.between(from: 1, to: 10),
    unity: %w[kg l m2 unit].sample,
    value: Faker::Number.decimal(l_digits: 2),
    category: Expense::CATEGORY.sample,
    payment_type: Expense::PAYMENT_TYPE.sample,
    user_id: User.pluck(:id).sample
  )
end

15.times do
  Income.create!(
    date: Faker::Date.between(from: 1.year.ago, to: Date.today),
    title: income_titles.sample,
    description: Faker::Commerce.department,
    quantity: Faker::Number.between(from: 1, to: 5),
    value: Faker::Number.decimal(l_digits: 2),
    user_id: User.pluck(:id).sample
  )
end
