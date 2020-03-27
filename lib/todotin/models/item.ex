defmodule Todotin.Model.Item do
  defstruct user_id: nil, item_id: nil, expiry: nil, title: nil, message: nil

  alias Todotin.Model.Item

  @type t :: %Item{
          user_id: String.t(),
          item_id: String.t(),
          expiry: DateTime.t(),
          title: String.t(),
          message: String.t()
        }
end
