defmodule Todotin.Router.Task do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello User Task")
  end

  match _ do
    send_resp(conn, 404, "User Task No here")
  end
end
