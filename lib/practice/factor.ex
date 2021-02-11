defmodule Practice.Factor do
  def parse_int(text) do
    {num, _} = Integer.parse(text)
    num
  end

  def factor(x) do
    num = parse_int(x)
    factors = [1]
    checkFactor = 2
    factor_helper(num, factors, checkFactor)
  end

  def factor_helper(num, factors, checkFactor) do
    if checkFactor <= num do
      if rem(num, checkFactor) == 0 do
        newFactors = factors ++ [checkFactor]
        factor_helper(div(num, checkFactor), newFactors, checkFactor)
      else
        factor_helper(num, factors, checkFactor + 1)
      end
    end
    factors
  end
end
