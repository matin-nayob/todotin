defmodule Todotin.Router.User do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello Users")
  end

  match _ do
    send_resp(conn, 404, "User No here")
  end
end
