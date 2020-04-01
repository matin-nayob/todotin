defmodule Todotin.Router.User do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello Users")
  end

  put "/new" do
    {status, body} =
      case conn.body_params do
        %{"user_id" => user_id, "name" => name} ->
          {:ok, message} = Todotin.Controllers.User.create_user(user_id, name)
          {201, message}

        _ ->
          {422, Jason.encode!(%{message: "Incorrect user parameters"})}
      end

    send_resp(conn, status, body)
  end

  get "/:user_id" do
    {status, body} = Todotin.Controllers.User.get_user(%{user_id: user_id})
    send_resp(conn, status, body)
  end

  match _ do
    send_resp(conn, 404, "User No here")
  end
end
