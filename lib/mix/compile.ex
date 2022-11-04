defmodule Mix.Tasks.Compile do
  @moduledoc "Compiles the nif"
  @shortdoc "Compiles NIF"
  use Mix.Task

  @impl Mix.Task
  def run(_) do
    Mix.shell().cmd("./gradlew runtime", cd: "sql")
  end
end
