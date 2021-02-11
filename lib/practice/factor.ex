defmodule Practice.Factor do

  def factor(x) do
    factors = [1]
    f = 2
    n = String.to_integer(x)
    finalFactors = factorHelp(n, f, factors)
    List.to_string(finalFactors)
  end

  def factorHelp(n, f, factors) do
    if f <= n do
      if rem(round(n), f) == 0 do
        factors ++ [f]
        nNew = n / f
        factorHelp(nNew, f, factors)
      else 
        fNew = f + 1
        factorHelp(n, fNew, factors)
      end
    else
      factors
    end
  end
end
