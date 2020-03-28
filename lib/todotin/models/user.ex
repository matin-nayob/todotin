defmodule Todotin.Model.User do
  @derive Jason.Encoder
  defstruct [:user_id, :name]

  alias Todotin.Model.User

  @type t :: %User{
          user_id: String.t(),
          name: String.t()
        }

  @spec new(String.t(), String.t()) :: User.t()
  def new(user_id, name) do
    %User{
      user_id: user_id,
      name: name
    }
  end
end
