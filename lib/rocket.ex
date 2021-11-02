defmodule Rocket do
  @moduledoc """
  Documentation for `Rocket`.
  """
  @doc """
  Creating the Rocket properties: its masss and status{land, launch} and the gravity.
  """
  defstruct [:fuel, :mass, :gravity]

  defguard is_fuel(fuel)
           when is_integer(fuel) or is_float(fuel)

  defguard is_mass(mass)
           when is_integer(mass) or is_float(mass)

  defguard is_gravity(gravity)
           when is_integer(gravity) or is_float(gravity)

  def create(fuel \\ 0, mass \\ 0, gravity \\ 0)

  def create(_, mass, _) when not is_mass(mass), do: {:error, "invalid mass"}

  def create(_, _, gravity) when not is_gravity(gravity), do: {:error, "invalid gravity"}

  def create(fuel, mass, gravity), do: %Rocket{fuel: fuel, mass: mass, gravity: gravity}

  @doc """
  Give the instructions to calculate the rocket fuel. Valid instructions are: land given as "A", and launch given as "B"
  """
  def simulate(rocket, instructions) do
    instructions
    |> String.graphemes()
    |> Enum.reduce_while(rocket, fn status, rocket ->
      case apply_instruction(rocket, status) do
        {:error, _} = error -> {:halt, error}
        rocket -> {:cont, rocket}
      end
    end)
  end

  defp apply_instruction(rocket, status)
      when status in ["A", "B"],
      do: %{rocket | fuel: add_fuel(rocket.mass, 10, status)}

  # landing
  defp add_fuel(mass, gravity, "A"), do: mass * 10 * 0.033 - 42

  # launching
  defp add_fuel(mass, gravity, "B"), do: mass * 10 * 0.042 - 33
end
