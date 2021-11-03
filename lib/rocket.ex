defmodule Rocket do
  @moduledoc """
  Documentation for `Rocket`.
  """
  @doc """
  Creating the Rocket properties: Starting fuel (default given as 0), its mass in kgs and the gravity of the planet involved. The guard clauses will ensure correct input.
  """
  defstruct [:fuel, :mass, :gravity]

  defguard is_fuel(fuel)
    when is_integer(fuel) or is_float(fuel)

  defguard is_mass(mass)
    when is_integer(mass) or is_float(mass)

  defguard is_gravity(gravity)
    when gravity in [:earth, :moon, :mars]

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

  @doc """
  Apply the functionality for landing and launching NB: This doc for private fn will be discarded in iex
  """
  defp apply_instruction(rocket, status)
      when status in ["A", "B"],
      do: %{rocket | fuel: add_fuel(rocket.mass, rocket.gravity, status)}

  @doc """
  Use a pattern matching algorith to get the fuel based on gravity
  """
  # landing
  defp add_fuel(mass, :earth, "A"), do: mass * 9.807 * 0.033 - 42
  defp add_fuel(mass, :moon, "A"), do: mass * 1.62 * 0.033 - 42
  defp add_fuel(mass, :mars, "A"), do: mass * 3.711 * 0.033 - 42

  # launching
  defp add_fuel(mass, :earth, "B"), do: mass * 9.807 * 0.042 - 33 
  defp add_fuel(mass, :moon, "B"), do: mass * 1.62 * 0.042 - 33 
  defp add_fuel(mass, :mars, "B"), do: mass * 3.711 * 0.042 - 33


end


# example for Apollo 11 Command and Service Module, with a weight of 28801 kg, to land it on the Earth, the required amount of fuel will be:
# Rocket.create(0, 28801, :earth) |> Rocket.simulate("A") →  %Rocket{fuel: 9278.896431000001, gravity: :earth, mass: 28801}

# for Apollo 11 CSM to launch from moon:
# Rocket.create(0, 28801, :moon) |> Rocket.simulate("B") → %Rocket{fuel: 1926.6200400000002, gravity: :moon, mass: 28801}

