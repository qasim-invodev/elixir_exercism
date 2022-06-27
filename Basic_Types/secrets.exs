#Exercise # 3: Secrets - Anonymous Functions and Bit Manipulation

# In this exercise, you've been tasked with writing the software for an encryption device that works by performing transformations on data. You need a way to flexibly create complicated functions by combining simpler functions together.

# For each task, return an anonymous function that can be invoked from the calling scope.

# All functions should expect integer arguments. Integers are also suitable for performing bitwise operations in Elixir.

defmodule Secrets do
  def secret_add(secret) do
    fn param -> param + secret end
  end

  def secret_subtract(secret) do
    fn param -> param - secret end
  end

  def secret_multiply(secret) do
    fn param -> param * secret end
  end

  def secret_divide(secret) do
    fn param -> div(param,secret) end
  end

  def secret_and(secret) do
    fn param -> Bitwise.band(param, secret) end
  end

  def secret_xor(secret) do
    fn param -> Bitwise.bxor(param, secret) end
  end

  def secret_combine(secret_function1, secret_function2) do
    fn param -> secret_function2.(secret_function1.(param)) end
  end
end
