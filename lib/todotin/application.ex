defmodule Todotin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Todotin.Router.Main, options: [port: cowboy_port()]}
    ]

    opts = [strategy: :one_for_one, name: Todotin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp cowboy_port do
    Application.get_env(:todotin, :cowboy_port, 8080)
  end
end
