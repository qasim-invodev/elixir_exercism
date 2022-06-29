# Exercise - 8 : Guessing Game - Topics : Multiple Arguments, Default Arguments and Guards

# You are creating a trivial online game where a friend can guess a secret number.
# You want to give some feedback, but not give away the answer with a guess.
# You need to devise a function to provide different responses depending on how the guess relates to the secret number.

defmodule GuessingGame do
  def compare(secret_number, guess) when secret_number == guess do
    "Correct"
  end
  def compare(secret_number, guess) when secret_number == guess+1 or secret_number == guess-1 do
    "So close"
  end
  def compare(secret_number, guess) when secret_number > guess+1 do
    "Too low"
  end
  def compare(secret_number, guess) when secret_number < guess-1 do
    "Too high"
  end
  def compare(secret_number, guess \\ :no_guess) do
    "Make a guess"
  end
end
