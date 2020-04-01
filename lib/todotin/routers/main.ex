defmodule Todotin.Router.Main do
  use Plug.Router

  plug(Plug.RequestId)
  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello there")
  end

  forward "/user/:user_id/task", to: Todotin.Router.Task

  forward "/user", to: Todotin.Router.User

  match _ do
    send_resp(conn, 404, "No here")
  end
end
