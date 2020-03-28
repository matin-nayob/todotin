defmodule Todotin.Database.Ddb do
  alias ExAws.Dynamo
  @table "todotin"

  @spec create_user(Todotin.DDB.User.t()) :: {:ok}
  def create_user(user) do
    Dynamo.put_item(
      @table,
      user
    )
    |> ExAws.request!()

    {:ok}
  end

  @spec create_item(Todotin.DDB.Item.t()) :: {:ok}
  def create_item(item) do
    Dynamo.put_item(
      @table,
      item
    )
    |> ExAws.request!()

    {:ok}
  end

  @spec get_user(String.t()) :: {:ok, Todotin.DDB.User.t()} | {:error, String.t()}
  def get_user(user_id) do
    result =
      Dynamo.query(
        @table,
        expression_attribute_values: [pk: "User\##{user_id}", sk: "User"],
        key_condition_expression: "pk = :pk AND sk = :sk"
      )
      |> ExAws.request!()
      |> Dynamo.decode_item(as: Todotin.DDB.User)
      |> List.first()

    case result do
      nil ->
        {:error, "User #{user_id} not found"}

      _ ->
        {:ok, result}
    end
  end

  @spec get_all_users() :: {:ok, [Todotin.DDB.User.t()] | []}
  def get_all_users do
    results =
      Dynamo.query(
        @table,
        expression_attribute_values: [pk: "User\#", sk: "User"],
        key_condition_expression: "sk = :sk AND begins_with(pk, :pk)",
        index_name: "gsisk"
      )
      |> ExAws.request!()
      |> Dynamo.decode_item(as: Todotin.DDB.User)

    {:ok, results}
  end

  def get_item do
  end

  def get_all_items do
  end
end
