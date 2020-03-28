defmodule Todotin.Model.Item do
  defstruct [:user_id, :item_id, :status, :title, :message]

  alias Todotin.Model.Item

  @type t :: %Item{
          user_id: String.t(),
          item_id: String.t(),
          status: String.t(),
          title: String.t(),
          message: String.t()
        }
end
