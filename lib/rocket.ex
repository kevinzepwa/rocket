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

  @doc """
  Apply the functionality for landing and launching NB: This doc for private fn will be discarded in iex
  """
  defp apply_status(rocket, status)
      when status in ["A", "B"],
      do: %{rocket | fuel: add_fuel(rocket.mass, rocket.gravity, status)}

  @doc """
  Use a pattern matching algorith to get the fuel based on gravity
  """
  # landing
  defp add_fuel(mass, :earth, "A"), do: (mass * 9.807 * 0.033 - 42 |> trunc())
  defp add_fuel(mass, :moon, "A"), do: (mass * 1.62 * 0.033 - 42 |> trunc())
  defp add_fuel(mass, :mars, "A"), do: (mass * 3.711 * 0.033 - 42 |> trunc())

  # launching
  defp add_fuel(mass, :earth, "B"), do: (mass * 9.807 * 0.042 - 33 |> trunc())
  defp add_fuel(mass, :moon, "B"), do: (mass * 1.62 * 0.042 - 33  |> trunc())
  defp add_fuel(mass, :mars, "B"), do: (mass * 3.711 * 0.042 - 33 |> trunc())

  @doc """
  Extra fuel mass needed given that adding fuel increases the mass of the ship. I thought we could apply some recursion here.
  """

  def my_rocket_fuel(simulate), do: simulate.fuel

  # defp add_extra_fuel(simulate, rocket) 
  #     when simulate.fuel > 0,
  #     do: %{simulate | fuel: add_fuel(simulate.fuel, rocket.gravity, status)}

  # defp add_extra_fuel(simulate)
  #     when simulate.fuel == 0,
  #     do: :ok

end


# example for Apollo 11 Command and Service Module, with a weight of 28801 kg, to land it on the Earth, the required amount of fuel will be:
# Rocket.create(0, 28801, :earth) |> Rocket.simulate("A") →  %Rocket{fuel: 9278, gravity: :earth, mass: 28801}

# for Apollo 11 CSM to launch from moon:
# Rocket.create(0, 28801, :moon) |> Rocket.simulate("B") → %Rocket{fuel: 1926, gravity: :moon, mass: 28801}

