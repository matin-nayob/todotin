defmodule Todotin.Model.Item do
  defstruct user_id: nil, item_id: nil, data: nil, title: nil, message: nil

  alias Todotin.Model.Item

  @type t :: %User{
          user_id: String.t(),
          item_id: String.t(),
          data: String.t(),
          title: String.t(),
          message: String.t()
        }
end
