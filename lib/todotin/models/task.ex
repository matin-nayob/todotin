defmodule Todotin.Model.Task do
  @derive Jason.Encoder
  defstruct [:user_id, :task_id, :status, :content]

  alias Todotin.Model.Task

  @type t :: %Task{
          user_id: String.t(),
          task_id: String.t(),
          status: String.t(),
          content: String.t()
        }

  @spec new(String.t(), String.t(), String.t()) :: Task.t()
  def new(user_id, content, task_id) do
    id =
      case task_id do
        "" ->
          UUID.uuid4(:hex)

        _ ->
          task_id
      end

    %Task{
      user_id: user_id,
      task_id: id,
      status: "Todo",
      content: content
    }
  end
end
