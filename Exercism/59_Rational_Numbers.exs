defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1,b1} = _a, {a2,b2} = _b) do
    sum1 = ((a1*b2) + (a2*b1))
    den = (b1*b2)
    add = {sum1,den}
    reduce(add)
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1,b1} = _a, {a2,b2} = _b) do
    diff = ((a1*b2) - (a2*b1))
    den = (b1*b2)
    sub = {diff,den}
    reduce(sub)
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1,b1} = _a, {a2,b2} = _b) do
    mul = {a1*a2, b1*b2}
    reduce(mul)
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1,b1} = _num, {a2,b2} = _den) when a2 != 0 do
    div = {a1*b2, a2*b1}
    reduce(div)
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a1,b1} = _a) do
    reduce({Kernel.abs(a1), Kernel.abs(b1)})
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a1,b1} = _a, n) when is_integer(n) do
    cond do
      n >= 0 -> reduce({a1**n, b1**n})
      n < 0 -> reduce({b1**Kernel.abs(n), a1**Kernel.abs(n)})
    end
  end

  def pow_rational({a1,b1} = _a, n) when is_float(n) do
    reduce({a1**n, b1**n})
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a1,b1} = _n) do
    Float.pow(Float.pow(x * 1.0,a1 * 1.0), 1/b1)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a1,b1}) do
    do_reduce({a1,b1}, 2)
  end

  defp do_reduce({a1,b1}, fac) when b1 != 0 and (fac > a1 and fac > b1) do
    if b1 < 0 do
      {-(a1),-(b1)}
    else
      {a1,b1}
    end
  end

  defp do_reduce({a1,b1}, fac) when b1 != 0 and (fac <= a1 or fac <= b1) do
    if rem(a1,fac) == 0 and rem(b1,fac) == 0 do
      n1 = div(a1,fac)
      d1 = div(b1,fac)
      num = {n1,d1}
      do_reduce(num, fac)
    else
      do_reduce({a1,b1}, fac+1)
    end
  end
end
