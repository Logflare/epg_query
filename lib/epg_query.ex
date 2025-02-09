defmodule EpgQuery do
  alias __MODULE__.Port
  @moduledoc false

  @doc """
  Parses an sql statement.

  ## Example

      iex> EpgQuery.parse("select * from some_table")
      %{
        "stmts"=> [...],
        "version" => ...
      }
  """
  @spec parse(String.t()) :: {:ok, map()} | {:error, String.t()}
  def parse(query) do
    with {:ok, json} <- Port.parse(query) do
      Jason.decode(json)
    end
  end
  def to_string(statements) when is_list(statements) do
    %{
      values: Enum.map(statements, &(&1["stmt"]))
    }
    |> Jason.encode!()
    |> Port.to_string()
  end
end
