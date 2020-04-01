defmodule Todotin.Controllers.User do
  alias Todotin.Utils.Messages

  @spec create_user(String.t(), String.t()) :: {:ok, String.t()}
  def create_user(user_id, name) do
    Todotin.Model.User.new(user_id, name)
    |> Todotin.DDB.User.encode()
    |> Todotin.Database.Ddb.create_user()

    {:ok, Jason.encode!(%{message: "User #{user_id} created"})}
  end

  @spec get_user(%{user_id: String.t}) :: {number, binary}
  def get_user(%{user_id: user_id} = props) do
    case Todotin.Database.Ddb.get_user(user_id) do
      [] ->
        {404, Messages.message_404("user not found", props)}
      [ddb_user] ->
        {200, Todotin.DDB.User.decode(ddb_user) |> Jason.encode!()}
      end
  end
end
