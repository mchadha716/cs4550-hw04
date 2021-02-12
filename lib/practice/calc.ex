defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr |> String.split(" ")
    tokens = tagTokens(expr)
    postfix = shuntingAlg(tokens, [], [])
    finalAnswer = calculate(postfix, [])
  end

  def tagTokens(list) do
    list
    |> Enum.map(fn x ->
    case x do
      "+" -> {:op, "+"}
      "-" -> {:op, "-"}
      "*" -> {:op, "*"}
      "/" -> {:op, "/"}
      _ -> {:num, parse_float(x)}
    end
    end)
  end

  def shuntingAlg(tokens, operandStack, operatorStack) do
    if length(tokens) > 0 do
      first = hd tokens
      case first do
        {:num, x} -> operandStack ++ [x]
        {:op, x} -> 
          if length(operatorStack) == 0 do
            operatorStack ++ [x]
          else
            firstOp = hd operatorStack
            rank = checkRank(x) - checkRank(firstOp)
            case rank do
              1 -> operatorStack = [x] ++ operatorStack
              0 -> operandStack ++ [firstOp]
                   operatorStack = tl operatorStack
                   operatorStack ++ [x]
              -1 -> operandStack ++ [firstOp] 
                    operatorStack = tl operatorStack
                    shuntingAlg(tokens, operandStack, operatorStack)
              _ -> nil
             end
          end
          _ -> nil
      end
      rest = tl tokens
      shuntingAlg(rest, operandStack, operatorStack)
    else 
      appended = operandStack ++ operatorStack
      appended
    end
  end

  def calculate(postfix, stack) do
    first = hd postfix
    if first == "+" or first == "-" or first == "*" or first == "/" do
      numOne = hd stack
      stack = tl stack
      numTwo = hd stack
      stack = tl stack

      case first do
        "+" -> calculation = numOne + numTwo
               stack = [calculation] ++ stack
        "-" -> calculation = numOne - numTwo
               stack = [calculation] ++ stack
        "*" -> calculation = numOne * numTwo
               stack = [calculation] ++ stack
        "/" -> calculation = numOne / numTwo
               stack = [calculation] ++ stack
        _ -> nil
      end
    else 
      stack = [first] ++ stack
    end
    if length(postfix) > 0 do
      rest = tl postfix
      calculate(rest, stack)
    else 
      finalAnswer = hd stack
      finalAnswer
    end
  end

end
