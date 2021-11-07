defmodule Rocket.Simulate do
  import Rocket.Apply_status

  @doc """
  Give the instructions based on the status to calculate the rocket fuel. Valid instructions are: land given as "A", and launch given as "B"
  """

  def simulate(rocket, status) do
    status
    |> String.graphemes()
    |> Enum.reduce_while(rocket, fn status, rocket ->
      case apply_status(rocket, status) do
        {:error, _} = error -> {:halt, error}
        rocket -> {:cont, rocket}
      end
    end)
  end
end
