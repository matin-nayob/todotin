defmodule Mix.Tasks.CreateUsers do
  use Mix.Task

  def run(_) do
    IO.puts("Creating Users")
    Mix.Task.run("app.start")
    range = 1..100
    Enum.each(range, fn x -> create_random_user(x) end)
    IO.puts("Finished creating users")
  end

  defp create_random_user(int) do
    Todotin.Controllers.User.create_user("User#{int}@random.com", "First #{int} Second #{int}")
  end
end
