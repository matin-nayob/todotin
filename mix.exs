defmodule Todotin.MixProject do
  use Mix.Project

  def project do
    [
      app: :todotin,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :plug_cowboy],
      mod: {Todotin.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, ">= 2.0.0"},
      {:ex_aws_dynamo, ">= 3.0.0"},
      {:jason, ">= 1.0.0"},
      {:hackney, ">= 1.0.0"},
      {:elixir_uuid, ">= 1.2.0"},
      {:tapper_plug, ">= 0.5.0"}
    ]
  end
end
