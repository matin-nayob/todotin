defmodule Todotin.Controllers.Task do
  @spec create_task(String.t(), String.t(), String.t()) :: {:ok, String.t()}
  def create_task(user_id, content, task_id \\ "") do
    task = Todotin.Model.Task.new(user_id, content, task_id)

    task
    |> Todotin.DDB.Task.encode()
    |> Todotin.Database.Ddb.create_task()

    {:ok, Jason.encode!(%{message: "Task #{task.task_id} created for user #{user_id}"})}
  end

  @spec get_task(String.t(), String.t()) :: {:ok, String.t()}
  def get_task(user_id, task_id) do
    case Todotin.Database.Ddb.get_task(user_id, task_id) do
      {:ok, ddb_task} ->
        {:ok, Todotin.DDB.Task.decode(ddb_task) |> Jason.encode!()}

      error ->
        error
    end
  end
end
