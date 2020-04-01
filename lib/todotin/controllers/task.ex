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
      [task | _tail = []] ->
        {200, Todotin.DDB.Task.decode(task) |> Jason.encode!()}

      [] ->
        {404, Messages.message_404("task not found", props)}
    end
  end

  @spec get_all_tasks(%{user_id: String.t()}) :: {number, binary}
  def get_all_tasks(%{user_id: user_id} = props) do
    tasks =
      Todotin.Database.Ddb.get_all_tasks(user_id)
      |> Enum.map(fn x -> Todotin.DDB.Task.decode(x) end)

    case tasks do
      [_ | _] ->
        {200, Jason.encode!(tasks)}

      [] ->
        {404, Messages.message_404("no tasks found", props)}
    end
  end
end
