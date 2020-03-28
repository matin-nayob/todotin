defmodule Todotin.DDB.Item do
  @derive ExAws.Dynamo.Encodable
  defstruct [:pk, :sk, :data, :title, :message]

  alias Todotin.DDB.Item

  @type t :: %Item{
          pk: String.t(),
          sk: String.t(),
          data: String.t(),
          title: String.t(),
          message: String.t()
        }

  @spec decode(Item.t()) :: Todotin.Model.Item.t()
  def decode(ddb_item) do
    %Todotin.Model.Item{
      user_id: ddb_item.pk,
      item_id: ddb_item.sk,
      status: ddb_item.data,
      title: ddb_item.title,
      message: ddb_item.message
    }
  end

  @spec encode(Todotin.Model.Item.t()) :: Item.t()
  def encode(item) do
    %Item{
      pk: "User\##{item.user_id}",
      sk: "Item\##{item.item_id}",
      data: item.status,
      title: item.title,
      message: item.message
    }
  end
end
