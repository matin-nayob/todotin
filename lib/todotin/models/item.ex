defmodule Todotin.Model.User do
  defstruct user_id: nil, first_name: nil, second_name: nil

  alias Todotin.Model.User

  @type t :: %User{
          user_id: String.t(),
          first_name: String.t(),
          second_name: String.t()
        }
end
