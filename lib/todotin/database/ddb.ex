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

  @spec create_task(Todotin.DDB.Task.t()) :: {:ok}
  def create_task(task) do
    Dynamo.put_item(
      @table,
      task
    )
    |> ExAws.request!()

    {:ok}
  end

  @spec get_user(String.t()) :: [Todotin.DDB.User.t()] | []
  def get_user(user_id) do
      Dynamo.query(
        "todotin",
        expression_attribute_values: [pk: "User\##{user_id}", sk: "User"],
        key_condition_expression: "pk = :pk AND sk = :sk"
      )
      |> ExAws.request!()
      |> Dynamo.decode_item(as: Todotin.DDB.User)
  end

  @spec get_all_users() :: [Todotin.DDB.User.t()] | []
  def get_all_users do
    Dynamo.query(
      @table,
      expression_attribute_values: [pk: "User\#", sk: "User"],
      key_condition_expression: "sk = :sk AND begins_with(pk, :pk)",
      index_name: "gsisk"
    )
    |> ExAws.request!()
    |> Dynamo.decode_item(as: Todotin.DDB.User)
  end

  @spec get_task(String.t(), String.t()) :: [Todotin.DDB.Task.t()] | []
  def get_task(user_id, task_id) do
    Dynamo.query(
      @table,
      expression_attribute_values: [pk: "User\##{user_id}", sk: "Task\##{task_id}"],
      key_condition_expression: "pk = :pk AND sk = :sk"
    )
    |> ExAws.request!()
    |> Dynamo.decode_item(as: Todotin.DDB.Task)
  end

  @spec get_all_tasks(String.t()) :: [Todotin.DDB.Task] | []
  def get_all_tasks(user_id) do
    Dynamo.query(
      @table,
      expression_attribute_values: [pk: "User\##{user_id}", sk: "Task\#"],
      key_condition_expression: "pk = :pk AND begins_with(sk, :sk)"
    )
    |> ExAws.request!()
    |> Dynamo.decode_item(as: Todotin.DDB.Task)
  end
end
