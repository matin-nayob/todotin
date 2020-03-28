defmodule Todotin.Model.User do
  defstruct [:user_id, :name]

  alias Todotin.Model.User

  @type t :: %User{
          user_id: String.t(),
          name: String.t()
        }
end
