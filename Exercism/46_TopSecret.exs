defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end
  def decode_secret_message_part({op, _, args} = ast, acc) when op in [:def, :defp] do
    {ast, [parse_args(args) | acc]}
  end
  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end
  defp parse_args(args) do
    {name,_,fun_args} = Enum.at(args,0)
    if is_list(fun_args) do
      arity = length(fun_args)
      if name == :when do
        parse_args(fun_args)
      else
        name
        |> Atom.to_string
        |> String.slice(0, arity)
      end
    else
      ""
    end
  end
  def decode_secret_message(string) do
    ast = to_ast(string)
    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)
    acc
    |> Enum.reverse()
    |> Enum.join()
  end
end
