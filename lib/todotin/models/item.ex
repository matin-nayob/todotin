defmodule Todotin.Model.Item do
  @derive Jason.Encoder
  defstruct [:user_id, :item_id, :status, :title, :message]

  alias Todotin.Model.Item

  @type t :: %Item{
          user_id: String.t(),
          item_id: String.t(),
          status: String.t(),
          title: String.t(),
          message: String.t()
        }

  @spec new(String.t(), String.t(), String.t(), String.t()) :: Item.t()
  def new(user_id, status, title, message) do
    %Item{
      user_id: user_id,
      item_id: UUID.uuid4(:hex),
      status: status,
      title: title,
      message: message
    }
  end
end
