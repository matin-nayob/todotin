defmodule Todotin.Router.Task do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 404, "Hello User Task")
  end

  get "/:task_id" do
    {:ok, body} = Todotin.Controllers.Task.get_task(conn.params["user_id"], task_id)
    send_resp(conn, 200, body)
  end

  put "/new" do
    {status, body} =
      case conn.body_params do
        %{"content" => content, "task_id" => task_id} ->
          {:ok, message} =
            Todotin.Controllers.Task.create_task(conn.params["user_id"], content, task_id)

          {201, message}

        %{"content" => content} ->
          {:ok, message} = Todotin.Controllers.Task.create_task(conn.params["user_id"], content)
          {201, message}

        _ ->
          {422, Jason.encode!(%{message: "Incorrect task parameters"})}
      end

    send_resp(conn, status, body)
  end

  match _ do
    send_resp(conn, 404, "User Task No here")
  end
end
