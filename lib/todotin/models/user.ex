defmodule Todotin.Model.User do
  defstruct user_id: nil, name: nil

  alias Todotin.Model.User

  @type t :: %User{
          user_id: String.t(),
          name: String.t()
        }
end
