defmodule EpgQueryTest do
  use ExUnit.Case

  test "parse/1, to_string/1" do
    assert {:ok,
            %{
              "stmts" => statements,
              "version" => _
            }} = EpgQuery.parse("select * from some_table")
    assert [%{}] = statements
    assert {:ok, sql} = EpgQuery.to_string(statements)
    assert String.downcase(sql) == "select * from some_table"
  end
end
