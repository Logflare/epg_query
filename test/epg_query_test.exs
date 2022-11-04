defmodule EpgQueryTest do
  use ExUnit.Case

  test "parses a simple statement" do
    assert {:ok,
            %{
              "stmts" => [_ | _],
              "version" => _
            }} = EpgQuery.parse("select * from some_table")
  end
end
