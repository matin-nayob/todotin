defmodule Todotin.Routers.TaskTest do
  use ExUnit.Case
  use Plug.Test

  alias Todotin.Router.Main

  @opt Main.init([])

  setup do
    user = Todotin.Model.User.new("task.router@test.com", "Task Router Test")
    task_id = "692fec7c21264e968639f05ab8a0e18d"
    task = Todotin.Model.Task.new(user.user_id, "Test Content woooooooooooo!", task_id)
    task_id_2 = "abcfec7c21264e968639f05ab8a0e18d"
    task_2 = Todotin.Model.Task.new(user.user_id, "Second task!", task_id_2)

    {:ok, user: user, task: task, task_2: task_2}
  end

  test "create task user", context do
    resp =
      :put
      |> conn("/user/new", %{:user_id => context.user.user_id, :name => context.user.name})
      |> Main.call(@opts)

    assert resp.state == :sent
    assert resp.status == 201
  end

  test "create task", context do
    resp =
      :put
      |> conn("/user/#{context.user.user_id}/task/new", %{
        :content => context.task.content,
        :task_id => context.task.task_id
      })
      |> Main.call(@opts)

    assert resp.state == :sent
    assert resp.status == 201
  end

  test "create task_2", context do
    resp =
      :put
      |> conn("/user/#{context.user.user_id}/task/new", %{
        :content => context.task_2.content,
        :task_id => context.task_2.task_id
      })
      |> Main.call(@opts)

    assert resp.state == :sent
    assert resp.status == 201
  end

  test "create task fail", context do
    resp =
      :put
      |> conn("/user/#{context.user.user_id}/task/new", %{:value => "wrong!"})
      |> Main.call(@opts)

    assert resp.state == :sent
    assert resp.status == 422
  end

  test "get task", context do
    resp =
      :get
      |> conn("/user/#{context.user.user_id}/task/#{context.task.task_id}", "")
      |> Main.call(@opts)

    assert resp.state == :sent
    assert resp.status == 200
  end

  test "get all tasks non existing", context do
    resp =
      :get
      |> conn("/user/doesnt.exist@missing.com/task/", "")
      |> Main.call(@opts)

    assert resp.state == :sent
    assert resp.status == 404
  end

  test "get all tasks", context do
    resp =
      :get
      |> conn("/user/#{context.user.user_id}/task/", "")
      |> Main.call(@opts)

    assert resp.state == :sent
    assert resp.status == 200
  end
end
