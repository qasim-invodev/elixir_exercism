#Exercise # 2: Freelancer Rates - Integers and Float Numbers

# In this exercise you'll be writing code to help a freelancer communicate with a project manager by providing a few utilities to quickly calculate daily and monthly rates, optionally with a given discount.

# We first establish a few rules between the freelancer and the project manager:

# The daily rate is 8 times the hourly rate.
# A month has 22 billable days.
# The freelancer is offering to apply a discount if the project manager chooses to let the freelancer bill per month, which can come in handy if there is a certain budget the project manager has to work with.

# Discounts are modeled as fractional numbers representing percentage, for example 25.0 (25%).

defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    discount = discount/100
    before_discount - (before_discount * discount)
  end

  def monthly_rate(hourly_rate, discount) do
    trunc(Float.ceil(apply_discount(daily_rate(hourly_rate) * 22, discount)))
  end

  def days_in_budget(budget, hourly_rate, discount) do
    Float.floor(budget/apply_discount(daily_rate(hourly_rate), discount),1)
  end
end
