defmodule Todotin.Controllers.Task do
  @spec create_user(String.t(), String.t()) :: {:ok, String.t()}
  def create_user(user_id, name) do
    Todotin.Model.User.new(user_id, name)
    |> Todotin.DDB.User.encode()
    |> Todotin.Database.Ddb.create_user()

    {:ok, Jason.encode!(%{message: "User #{user_id} created"})}
  end

  @spec get_user(String.t()) :: {:ok, String.t()}
  def get_user(user_id) do
    case Todotin.Database.Ddb.get_user(user_id) do
      {:ok, ddb_user} ->
        {:ok, Todotin.DDB.User.decode(ddb_user) |> Jason.encode!()}
      error ->
        error
    end
  end
end
