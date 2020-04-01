defmodule Todotin.Utils.Messages do
  @spec message_404(binary(), map()) :: binary()
  def message_404(reason, props) do
    %{reason: reason}
    |> Map.merge(props)
    |> Jason.encode!()
  end
end
