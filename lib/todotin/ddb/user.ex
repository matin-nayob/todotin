defmodule Todotin.DDB.User do
  @derive ExAws.Dynamo.Encodable
  defstruct [:pk, :sk, :name]

  alias Todotin.DDB.User

  @type t :: %User{
          pk: String.t(),
          sk: String.t(),
          name: String.t()
        }

  @spec decode(User.t()) :: Todotin.Model.User.t()
  def decode(ddb_user) do
    %Todotin.Model.User{
      user_id: ddb_user.pk,
      name: ddb_user.name
    }
  end

  @spec encode(Todotin.Model.User.t()) :: User.t()
  def encode(user) do
    %User{
      pk: "User\##{user.user_id}",
      sk: "User",
      name: "#{user.name}"
    }
  end
end
