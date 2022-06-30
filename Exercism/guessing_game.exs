# Exercise - 8 : Guessing Game - Topics : Multiple Arguments, Default Arguments and Guards

# You are creating a trivial online game where a friend can guess a secret number.
# You want to give some feedback, but not give away the answer with a guess.
# You need to devise a function to provide different responses depending on how the guess relates to the secret number.

defmodule GuessingGame do
  def compare(secret, guess \\ :no_guess)
  def compare(_secret, :no_guess), do: "Make a guess"
  def compare(secret, guess) when secret == guess, do: "Correct"
  def compare(secret, guess) when (secret - guess) in [-1, 1], do: "So close"
  def compare(secret, guess) when secret < guess, do: "Too high"
  def compare(secret, guess) when secret > guess, do: "Too low"
end
