defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, date} = NaiveDateTime.from_iso8601(string)
    date
  end

  def before_noon?(datetime) do
    time = NaiveDateTime.to_time(datetime)
    set_time = ~T[12:00:00]
    if Time.compare(time, set_time) == :gt or Time.compare(time, set_time) == :eq do
      false
    else
      true
    end
  end

  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      Date.add(NaiveDateTime.to_date(checkout_datetime),28)
    else
      Date.add(NaiveDateTime.to_date(checkout_datetime),29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    late = Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date)
    if late <= 0, do: 0, else: late
  end

  def monday?(datetime) do
    day = Date.day_of_week(NaiveDateTime.to_date(datetime))
    if day == 1, do: true, else: false
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout = datetime_from_string(checkout)
    actual_return = datetime_from_string(return)
    planned_return = return_date(checkout)
    late = days_late(planned_return, actual_return)
    if monday?(actual_return) do
      if late > 0, do: div(rate * late,2), else: 0
    else
      if late > 0, do: rate * late, else: 0
    end
  end
end
