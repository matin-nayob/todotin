defmodule Todotin.Controllers.Task do
  alias Todotin.Utils.Messages

  @spec create_task(String.t(), String.t(), String.t()) :: {:ok, String.t()}
  def create_task(user_id, content, task_id \\ "") do
    task = Todotin.Model.Task.new(user_id, content, task_id)

    task
    |> Todotin.DDB.Task.encode()
    |> Todotin.Database.Ddb.create_task()

    {:ok, Jason.encode!(%{message: "Task #{task.task_id} created for user #{user_id}"})}
  end

  @spec get_task(%{user_id: String.t(), task_id: String.t()}) :: {number(), binary()}
  def get_task(%{user_id: user_id, task_id: task_id} = props) do
    case Todotin.Database.Ddb.get_task(user_id, task_id) do
      [] ->
        {404, Jason.encode!(Messages.message_404("task not found", props))}

      [ddb_task] ->
        {200, Todotin.DDB.Task.decode(ddb_task) |> Jason.encode!()}
    end
  end

  @spec get_all_tasks(String.t()) :: [Todotin.Model.Task] | []
  def get_all_tasks(user_id) do
    Todotin.Database.Ddb.get_all_tasks(user_id)
    |> Enum.map(fn x -> Todotin.DDB.Task.decode(x) end)
  end
end
