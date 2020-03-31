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

  @spec new(String.t(), String.t()) :: Task.t()
  def new(user_id, content) do
    %Task{
      user_id: user_id,
      task_id: UUID.uuid4(:hex),
      status: "Todo",
      content: content
    }
  end
end
