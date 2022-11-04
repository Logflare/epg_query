defmodule EpgQuery.MixProject do
  use Mix.Project

  def project do
    [
      app: :epg_query,
      version: "0.1.2",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: [epgquery_port: []],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {EpgQuery.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "~> 0.25.0"},
      {:jason, "~> 1.3"},
      {:benchee, "~> 1.0", only: :dev}
    ]
  end
end
