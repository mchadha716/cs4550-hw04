defmodule Practice.Factor do

  def parseFloat(text) do
    {num, _} = Float.parse(text)
    num
  end

  def factor(x) do
    factors = [1]
    f = 2
    n = parseFloat(x)
    # n = String.to_integer(x)
    factorHelp(n, f, factors)
  end

  def factorHelp(n, f, factors) do
    if f <= n do
      if rem(trunc(n), f) == 0 do
        factors ++ [f]
        nNew = n / f
        factorHelp(nNew, f, factors)
      else 
        fNew = f + 1
        factorHelp(n, fNew, factors)
      end
    else
      factors
      |> tl
      |> Enum.map(fn n -> to_string(trunc(n)) end)
      |> Enum.join(" ")
    end
    factors
  end
end
