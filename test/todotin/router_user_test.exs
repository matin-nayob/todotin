defmodule Todotin.Routers.UserTest do
  use ExUnit.Case
  use Plug.Test

  alias Todotin.Router.Main

  @opt Main.init([])

  setup do
    user = Todotin.Model.User.new("user.router@test.com", "User Router Test")

    {:ok, user: user, user_id: user.user_id}
  end

  test "get user home", context do
    resp =
      :get
      |> conn("/user/", "")
      |> Main.call(@opts)

    assert resp.state == :sent
    assert resp.status == 200
  end

  test "get user", context do
    resp =
      :get
      |> conn("/user/#{context[:user_id]}", "")
      |> Main.call(@opts)

    assert resp.state == :sent
    assert resp.status == 200
  end
end
