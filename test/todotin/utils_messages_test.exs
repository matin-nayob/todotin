defmodule Todotin.Utils.MessagesTest do
  use ExUnit.Case

  alias Todotin.Utils.Messages

  test "message_404" do
    reason = "test reason"
    prop1 = "prop1"
    prop2 = "prop2"
    props = %{prop1: prop1, prop2: prop2}

    expected = Jason.encode!(%{reason: reason, prop1: prop1, prop2: prop2})
    actual = Messages.message_404(reason, props)

    assert expected == actual
  end
end
