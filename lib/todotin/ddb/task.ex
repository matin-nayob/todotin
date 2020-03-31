defmodule Todotin.DDB.Task do
  @derive ExAws.Dynamo.Encodable
  defstruct [:pk, :sk, :data, :content]

  alias Todotin.DDB.Task

  @type t :: %Task{
          pk: String.t(),
          sk: String.t(),
          data: String.t(),
          content: String.t()
        }

  @spec decode(Task.t()) :: Todotin.Model.Task.t()
  def decode(ddb_task) do
    %Todotin.Model.Task{
      user_id: String.split(ddb_task.pk, "#") |> List.last(),
      task_id: String.split(ddb_task.sk, "#") |> List.last(),
      status: ddb_task.data,
      content: ddb_task.content
    }
  end

  @spec encode(Todotin.Model.Task.t()) :: Task.t()
  def encode(task) do
    %Task{
      pk: "User\##{task.user_id}",
      sk: "Task\##{task.task_id}",
      data: task.status,
      content: task.content
    }
  end
end
