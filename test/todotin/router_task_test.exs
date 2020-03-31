defmodule Todotin.Routers.TaskTest do
  use ExUnit.Case
  use Plug.Test

  alias Todotin.Router.Main

  @opt Main.init([])

  setup do
    user = Todotin.Model.User.new("task.router@test.com", "Task Router Test")


    {:ok, user: user, user_id: user.user_id}
  end

  test "create task user"

  test "create task"

  test "create task fail"

  test "get task"

  test "get all tasks"
end
